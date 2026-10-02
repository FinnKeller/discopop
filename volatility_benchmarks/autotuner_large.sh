#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
HARNESS_DIR="${REPO_ROOT}/new_benchmark_harness"
BENCHMARKS_DIR="${HARNESS_DIR}/benchmarks"
CONFIGURE_SCRIPT="${HARNESS_DIR}/configure.sh"
VENV_PIP="${REPO_ROOT}/venv/bin/pip"
VENV_PYTHON="${REPO_ROOT}/venv/bin/python"
PROJECT_MANAGER="${REPO_ROOT}/venv/bin/discopop"
PROFILER_FILE="${REPO_ROOT}/profiler/rtlib/runtimeFunctionsGlobals.cpp"
COMPARISON_SCRIPT="${SCRIPT_DIR}/comparison_volatility_cases.py"
CONFIGURATION="${CONFIGURATION:-tiny}"
BENCHMARK_FILTER="${BENCHMARK_FILTER:-LULESH}"
BATCH_VALUES=(${BATCH_VALUES:-128 256 512 1024})
PROJECT_MANAGER_LOG_LEVEL="${PROJECT_MANAGER_LOG_LEVEL:-WARNING}"
PROJECT_MANAGER_TIMEOUT="${PROJECT_MANAGER_TIMEOUT:-120}"
LIBSTDCXX_WORKAROUND=""
LIBOMP_PREFIX=""

if [ "$#" -ne 0 ]; then
    echo "Usage: $0" >&2
    echo "Runs the ${CONFIGURATION} configuration for every matching new benchmark harness project." >&2
    exit 1
fi

for required_file in "${VENV_PIP}" "${VENV_PYTHON}" "${PROJECT_MANAGER}" "${PROFILER_FILE}" "${COMPARISON_SCRIPT}" "${CONFIGURE_SCRIPT}" "${BENCHMARKS_DIR}"; do
    if [ ! -e "${required_file}" ]; then
        echo "ERROR: required path not found: ${required_file}" >&2
        exit 1
    fi
done

echo "=== Configuring benchmark compilers ==="
(
    cd "${HARNESS_DIR}"
    bash ./configure.sh
)

PROJECTS=()
while IFS= read -r project; do
    PROJECTS+=("${project}")
done < <(
    find "${BENCHMARKS_DIR}" -type f \
        -path "*/.discopop/project/configs/${CONFIGURATION}/execute.sh" \
        -print |
        sed "s#/.discopop/project/configs/${CONFIGURATION}/execute.sh\$##" |
        sort
)

if [ -n "${BENCHMARK_FILTER}" ]; then
    FILTERED_PROJECTS=()
    for project in "${PROJECTS[@]}"; do
        if [[ "${project}" == *"${BENCHMARK_FILTER}"* ]]; then
            FILTERED_PROJECTS+=("${project}")
        fi
    done
    PROJECTS=("${FILTERED_PROJECTS[@]}")
fi

if [ "${#PROJECTS[@]}" -eq 0 ] || [ "${#BATCH_VALUES[@]}" -eq 0 ]; then
    echo "ERROR: no matching projects with a ${CONFIGURATION} configuration found in ${BENCHMARKS_DIR}." >&2
    exit 1
fi

PROFILER_BACKUP="$(mktemp)"
cp "${PROFILER_FILE}" "${PROFILER_BACKUP}"

cleanup() {
    cp "${PROFILER_BACKUP}" "${PROFILER_FILE}"
    rm -f "${PROFILER_BACKUP}" "${PROFILER_FILE}.bak"
    if [ -n "${LIBSTDCXX_WORKAROUND}" ]; then
        rm -rf "${LIBSTDCXX_WORKAROUND}"
    fi
}
trap cleanup EXIT

update_write_sample_batch() {
    local value=$1
    sed -i.bak -E "s/WRITE_SAMPLE_BATCH = [0-9]+;/WRITE_SAMPLE_BATCH = ${value};/" "${PROFILER_FILE}"
}

run_project() {
    local project_path=$1
    local config_path="${project_path}/.discopop/project/configs/${CONFIGURATION}"
    local dependencies="${project_path}/.discopop/profiler/dynamic_dependencies.txt"

    if [ ! -d "${config_path}" ]; then
        echo "ERROR: configuration not found for ${project_path}: ${config_path}" >&2
        return 1
    fi

    rm -f "${dependencies}"
    (
        cd "${project_path}"
        if ! "${PROJECT_MANAGER}" \
            --project "${project_path}" \
            --execute "${CONFIGURATION}:dp:1" \
            --inplace \
            --skip-cleanup \
            --log "${PROJECT_MANAGER_LOG_LEVEL}" \
            --timeout-compilation "${PROJECT_MANAGER_TIMEOUT}" \
            --timeout-execution "${PROJECT_MANAGER_TIMEOUT}" \
            --timeout-validation "${PROJECT_MANAGER_TIMEOUT}"; then
            echo "ERROR: ProjectManager failed for ${project_path} (${CONFIGURATION}:dp:1)." >&2
            return 1
        fi
    )

    for _ in {1..20}; do
        [ -f "${dependencies}" ] && return 0
        sleep 1
    done
    echo "ERROR: ${dependencies} was not created after execution." >&2
    return 1
}

compare_project() {
    local project_path=$1
    local baseline=$2
    local sampled=$3
    local label=$4

    (
        cd "${project_path}"
        "${VENV_PYTHON}" "${COMPARISON_SCRIPT}" "${baseline}" "${sampled}" "${label}"
    )
}

project_label() {
    local project_path=$1
    basename "${project_path}"
}

cd "${REPO_ROOT}"

if [ "$(uname -s)" = "Darwin" ]; then
    if command -v brew >/dev/null 2>&1; then
        LIBOMP_PREFIX="$(brew --prefix libomp 2>/dev/null || true)"
    fi
    if [ -z "${LIBOMP_PREFIX}" ] || [ ! -d "${LIBOMP_PREFIX}/lib" ]; then
        echo "ERROR: Homebrew libomp is required on macOS. Install it with: brew install libomp" >&2
        exit 1
    fi
    export CPPFLAGS="-I${LIBOMP_PREFIX}/include${CPPFLAGS:+ ${CPPFLAGS}}"
    export CPLUS_INCLUDE_PATH="${LIBOMP_PREFIX}/include${CPLUS_INCLUDE_PATH:+:${CPLUS_INCLUDE_PATH}}"
    export LDFLAGS="-L${LIBOMP_PREFIX}/lib${LDFLAGS:+ ${LDFLAGS}}"
    export LIBRARY_PATH="${LIBOMP_PREFIX}/lib${LIBRARY_PATH:+:${LIBRARY_PATH}}"

    LIBSTDCXX_WORKAROUND="$(mktemp -d)"
    if [ -f "/usr/lib/libc++.1.dylib" ]; then
        ln -s "/usr/lib/libc++.1.dylib" "${LIBSTDCXX_WORKAROUND}/libstdc++.dylib"
    else
        SDKROOT="$(xcrun --sdk macosx --show-sdk-path)"
        ln -s "${SDKROOT}/usr/lib/libc++.tbd" "${LIBSTDCXX_WORKAROUND}/libstdc++.tbd"
    fi
    export LIBRARY_PATH="${LIBSTDCXX_WORKAROUND}:${LIBRARY_PATH}"
fi

echo "=== Installing profiler without sampling ==="
"${VENV_PIP}" install ./profiler \
    --config-settings="cmake.args=-DDP_INTERNAL_TIMER=1;-DDP_NUM_WORKERS=0;-DDP_NAIVE_SAMPLING=0" -v

for project in "${PROJECTS[@]}"; do
    label="$(project_label "${project}")"
    results_dir="${project}/autotuner_large_results"
    mkdir -p "${results_dir}"
    rm -f "${results_dir}/no_sampling.txt" "${results_dir}/volatility.txt"
    echo ""
    echo "=== ${label}: baseline ==="
    run_project "${project}"
    cp "${project}/.discopop/profiler/dynamic_dependencies.txt" \
        "${results_dir}/no_sampling.txt"
done

echo "=== Installing profiler with sampling ==="
update_write_sample_batch "${BATCH_VALUES[0]}"
"${VENV_PIP}" install ./profiler \
    --config-settings="cmake.args=-DDP_INTERNAL_TIMER=1;-DDP_NUM_WORKERS=0;-DDP_NAIVE_SAMPLING=1" -v

for batch in "${BATCH_VALUES[@]}"; do
    if [ "${batch}" != "${BATCH_VALUES[0]}" ]; then
        update_write_sample_batch "${batch}"
        "${VENV_PIP}" install ./profiler \
            --config-settings="cmake.args=-DDP_INTERNAL_TIMER=1;-DDP_NUM_WORKERS=0;-DDP_NAIVE_SAMPLING=1" -v
    fi

    echo ""
    echo "=== WRITE_SAMPLE_BATCH=${batch} ==="
    for project in "${PROJECTS[@]}"; do
        label="$(project_label "${project}")"
        results_dir="${project}/autotuner_large_results"
        sampled="${results_dir}/sampling_${batch}.txt"
        comparison_label="${label}_${CONFIGURATION}_batch${batch}"

        echo "  ${label}"
        run_project "${project}"
        cp "${project}/.discopop/profiler/dynamic_dependencies.txt" "${sampled}"
        compare_project "${project}" "${results_dir}/no_sampling.txt" "${sampled}" "${comparison_label}"

        if grep -q "^Equivalent after normalization\.$" \
            "${project}/output_${comparison_label}.txt"; then
            echo "${batch}: STABLE" | tee -a "${results_dir}/volatility.txt"
        else
            echo "${batch}: VOLATILE" | tee -a "${results_dir}/volatility.txt"
        fi
    done
done

echo ""
echo "=== Volatility Summary ==="
for project in "${PROJECTS[@]}"; do
    label="$(project_label "${project}")"
    echo ""
    echo "${label}:"
    cat "${project}/autotuner_large_results/volatility.txt"
done
