#!/bin/bash
set -euo pipefail


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
LIBOMP_PREFIX="$(brew --prefix libomp 2>/dev/null || echo /opt/homebrew/opt/libomp)"
export CPLUS_INCLUDE_PATH="${LIBOMP_PREFIX}/include${CPLUS_INCLUDE_PATH:+:${CPLUS_INCLUDE_PATH}}"
export LIBRARY_PATH="${LIBOMP_PREFIX}/lib${LIBRARY_PATH:+:${LIBRARY_PATH}}"
export DYLD_LIBRARY_PATH="${LIBOMP_PREFIX}/lib${DYLD_LIBRARY_PATH:+:${DYLD_LIBRARY_PATH}}"
VENV_PIP="${REPO_ROOT}/venv/bin/pip"
VENV_PYTHON="${REPO_ROOT}/venv/bin/python"
DISCOPOP_CXX="${REPO_ROOT}/venv/bin/discopop_cxx"

BATCH_VALUES=(${BATCH_VALUES:-64 128 256 512})
REPEAT_COUNT=${REPEAT_COUNT:-100}

PROFILER_FILE="${REPO_ROOT}/profiler/rtlib/runtimeFunctionsGlobals.cpp"
WRAP_SCRIPT="${SCRIPT_DIR}/wrap_main_loop.py"
COMPARISON_SCRIPT="${SCRIPT_DIR}/comparison_volatility_cases.py"
# The generated examples are created in this script's generated_volatility directory.
BENCHMARKS_DIR="${SCRIPT_DIR}/benchmarks/lpp_test/generated_volatility"
if [ ! -f "${BENCHMARKS_DIR}/volatility_none.cpp" ] \
    && [ -d "${BENCHMARKS_DIR}/generated_volatility" ]; then
    BENCHMARKS_DIR="${BENCHMARKS_DIR}/generated_volatility"
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
if ! compgen -G "${BENCHMARKS_DIR}/*/*.cpp" > /dev/null; then
    echo "ERROR: no benchmark cpp files found in subfolders of ${BENCHMARKS_DIR}." >&2
    exit 1
fi

update_write_sample_batch() {
    local value=$1
    sed -i.bak -E "s/WRITE_SAMPLE_BATCH = [0-9]+;/WRITE_SAMPLE_BATCH = ${value};/" "${PROFILER_FILE}"
}

build_and_run_case() {
    local dir=$1
    local orig_cpp="${dir}.cpp"
    local wrapped_cpp="${dir}_wrapped.cpp"

    rm -rf .discopop/ a.out a.out.dSYM

    "${VENV_PYTHON}" "${WRAP_SCRIPT}" "${orig_cpp}" "${wrapped_cpp}" "${REPEAT_COUNT}"
    if [ ! -f "${wrapped_cpp}" ]; then
        echo "ERROR: wrap_main_loop.py did not produce ${wrapped_cpp} for ${dir} - aborting." >&2
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
cd "${BENCHMARKS_DIR}"
for benchmark_dir in */; do
    [ -d "${benchmark_dir}" ] || continue
    cd "${benchmark_dir}"
    for cpp_file in *.cpp; do
        [ -f "${cpp_file}" ] || continue
        dir="${cpp_file%.cpp}"
        echo "  ${benchmark_dir%/}/${dir}"
        build_and_run_case "${dir}"
        mv .discopop/profiler/dynamic_dependencies.txt "no_sampling_${dir}.txt"
        cp -r .discopop ".discopop_no_sampling_${dir}"
        rm -rf .discopop
    done
    cd ..
done
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

    cd "${BENCHMARKS_DIR}"

    for benchmark_dir in */; do
        [ -d "${benchmark_dir}" ] || continue
        cd "${benchmark_dir}"
        for cpp_file in *.cpp; do
            if [ -f "$cpp_file" ]; then
                dir="${cpp_file%.cpp}"
                benchmark_name="${benchmark_dir%/}_${dir}"
                echo "  ${benchmark_name}"

            build_and_run_case "${dir}"

            out_name="batch${batch}_${dir}.txt"

            mv .discopop/profiler/dynamic_dependencies.txt "${out_name}"
            cp -r .discopop ".discopop_batch${batch}_${dir}"
            rm -rf .discopop

            baseline_file="no_sampling_${dir}.txt"
            label="${benchmark_name}_batch${batch}"

            "${VENV_PYTHON}" "${COMPARISON_SCRIPT}" \
                "${baseline_file}" \
                "${out_name}" \
                "${label}"

            output_file="output_${label}.txt"

            if comparison_is_equivalent "${output_file}"; then

                echo "    -> equivalent"

                echo "${batch}: STABLE" \
                    >> "${VOLATILITY_DIR}/${benchmark_name}.txt"

            else

                echo "    -> VOLATILITY FOUND"

                echo "${batch}: VOLATILE" \
                    >> "${VOLATILITY_DIR}/${benchmark_name}.txt"

            fi
            fi
        done
        cd ..
    done

    cd "${REPO_ROOT}"
done

rm -f "${PROFILER_FILE}.bak"

echo ""
echo "=== Volatility Summary ==="

cd "${BENCHMARKS_DIR}"

for benchmark_dir in */; do
    [ -d "${benchmark_dir}" ] || continue
    for cpp_file in "${benchmark_dir}"*.cpp; do
        if [ -f "$cpp_file" ]; then
            dir="${cpp_file##*/}"
            dir="${dir%.cpp}"
            benchmark_name="${benchmark_dir%/}_${dir}"
            result_file="${VOLATILITY_DIR}/${benchmark_name}.txt"

            echo ""
            echo "${benchmark_name}:"

        if [ -f "${result_file}" ]; then
            cat "${result_file}"
        else
            echo "  No results."
        fi
    done
done

cd "${REPO_ROOT}"

echo ""
echo "Done."
