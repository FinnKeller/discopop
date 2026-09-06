#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
VENV_PIP="${REPO_ROOT}/venv/bin/pip"
VENV_PYTHON="${REPO_ROOT}/venv/bin/python"
DISCOPOP_CXX="${REPO_ROOT}/venv/bin/discopop_cxx"

BATCH_VALUES=(${BATCH_VALUES:-64 128 256 512 1024 2048})
REPEAT_COUNT=${REPEAT_COUNT:-5}

PROFILER_FILE="${REPO_ROOT}/profiler/rtlib/runtimeFunctionsGlobals.cpp"
WRAP_SCRIPT="${SCRIPT_DIR}/wrap_main_loop.py"
COMPARISON_SCRIPT="${SCRIPT_DIR}/comparison_volatility_cases.py"
BENCHMARKS_DIR="${SCRIPT_DIR}/benchmarks/automatic"

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <benchmark-file.cpp>" >&2
    exit 1
fi

TARGET_INPUT="$1"
if [ -f "${TARGET_INPUT}" ]; then
    TARGET_CPP="$(cd "$(dirname "${TARGET_INPUT}")" && pwd)/$(basename "${TARGET_INPUT}")"
elif [ -f "${BENCHMARKS_DIR}/${TARGET_INPUT}" ]; then
    TARGET_CPP="$(cd "${BENCHMARKS_DIR}/$(dirname "${TARGET_INPUT}")" && pwd)/$(basename "${TARGET_INPUT}")"
else
    echo "ERROR: Benchmark file not found: ${TARGET_INPUT}" >&2
    exit 1
fi

TARGET_DIR="$(dirname "${TARGET_CPP}")"
TARGET_FILE="$(basename "${TARGET_CPP}")"
TARGET_STEM="${TARGET_FILE%.cpp}"

if [ "${TARGET_FILE}" = "${TARGET_STEM}" ]; then
    echo "ERROR: Target file must have a .cpp extension: ${TARGET_CPP}" >&2
    exit 1
fi

if [ ! -f "${WRAP_SCRIPT}" ]; then
    echo "ERROR: wrap_main_loop.py not found at ${WRAP_SCRIPT}." >&2
    exit 1
fi
if [ ! -f "${COMPARISON_SCRIPT}" ]; then
    echo "ERROR: comparison_volatility_cases.py not found at ${COMPARISON_SCRIPT}." >&2
    exit 1
fi
if [ ! -x "${VENV_PIP}" ]; then
    echo "ERROR: pip not found at ${VENV_PIP}. Ensure the repository venv is set up." >&2
    exit 1
fi
if [ ! -x "${VENV_PYTHON}" ]; then
    echo "ERROR: python not found at ${VENV_PYTHON}. Ensure the repository venv is set up." >&2
    exit 1
fi
if [ ! -x "${DISCOPOP_CXX}" ]; then
    echo "ERROR: discopop_cxx not found at ${DISCOPOP_CXX}. Install project packages into the repository venv." >&2
    exit 1
fi

update_write_sample_batch() {
    local value=$1
    sed -i.bak -E "s/WRITE_SAMPLE_BATCH = [0-9]+;/WRITE_SAMPLE_BATCH = ${value};/" "${PROFILER_FILE}"
}

build_and_run_case() {
    local orig_cpp=$1
    local wrapped_cpp="${orig_cpp%.cpp}_wrapped.cpp"

    rm -rf .discopop/ a.out a.out.dSYM

    "${VENV_PYTHON}" "${WRAP_SCRIPT}" "${orig_cpp}" "${wrapped_cpp}" "${REPEAT_COUNT}"
    if [ ! -f "${wrapped_cpp}" ]; then
        echo "ERROR: wrap_main_loop.py did not produce ${wrapped_cpp} for ${orig_cpp} - aborting." >&2
        exit 1
    fi

    "${DISCOPOP_CXX}" "${wrapped_cpp}" -o a.out
    ./a.out

    rm -f "${wrapped_cpp}"
}

comparison_is_equivalent() {
    local output_file=$1
    [ -f "${output_file}" ] && grep -q "^Equivalent after normalization\.$" "${output_file}"
}

cd "${REPO_ROOT}"
# 1. No Sampling
echo "=== Baseline: no sampling (repeat=${REPEAT_COUNT}) ==="
"${VENV_PIP}" install ./profiler --config-settings="cmake.args=-DDP_INTERNAL_TIMER=1;-DDP_NUM_WORKERS=0;-DDP_NAIVE_SAMPLING=0" -v
cd "${TARGET_DIR}"
echo "  ${TARGET_FILE}"
build_and_run_case "${TARGET_FILE}"
baseline_file="no_sampling_${TARGET_STEM}.txt"
mv .discopop/profiler/dynamic_dependencies.txt "${baseline_file}"
cp -r .discopop .discopop_no_sampling
rm -rf .discopop
cd "${REPO_ROOT}"


VOLATILITY_DIR="${BENCHMARKS_DIR}/volatility_results"
rm -rf "${VOLATILITY_DIR}"
mkdir -p "${VOLATILITY_DIR}"
#2. Sampling
for batch in "${BATCH_VALUES[@]}"; do

    echo "=== WRITE_SAMPLE_BATCH=${batch} (repeat=${REPEAT_COUNT}) ==="

    update_write_sample_batch "${batch}"
    diff "${PROFILER_FILE}.bak" "${PROFILER_FILE}" || true

    "${VENV_PIP}" install ./profiler \
        --config-settings="cmake.args=-DDP_INTERNAL_TIMER=1;-DDP_NUM_WORKERS=0;-DDP_NAIVE_SAMPLING=1" \
        -v

    cd "${TARGET_DIR}"
    echo "  ${TARGET_FILE}"

    build_and_run_case "${TARGET_FILE}"

    out_name="batch${batch}_${TARGET_STEM}.txt"
    mv .discopop/profiler/dynamic_dependencies.txt "${out_name}"
    cp -r .discopop ".discopop_batch${batch}"
    rm -rf .discopop

    label="${TARGET_STEM}_batch${batch}"

    "${VENV_PYTHON}" "${COMPARISON_SCRIPT}" \
        "${baseline_file}" \
        "${out_name}" \
        "${label}"

    output_file="output_${label}.txt"

    if comparison_is_equivalent "${output_file}"; then
        echo "    -> equivalent"
        echo "${batch}: STABLE" \
            >> "${VOLATILITY_DIR}/${TARGET_STEM}.txt"
    else
        echo "    -> VOLATILITY FOUND"
        echo "${batch}: VOLATILE" \
            >> "${VOLATILITY_DIR}/${TARGET_STEM}.txt"
    fi

    cd "${REPO_ROOT}"
done

rm -f "${PROFILER_FILE}.bak"

echo ""
echo "=== Volatility Summary ==="

result_file="${VOLATILITY_DIR}/${TARGET_STEM}.txt"

echo ""
echo "${TARGET_STEM}:"

if [ -f "${result_file}" ]; then
    cat "${result_file}"
else
    echo "  No results."
fi

cd "${REPO_ROOT}"

echo ""
echo "Done."
