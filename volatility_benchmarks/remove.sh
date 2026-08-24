#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BENCHMARK_ROOT="${SCRIPT_DIR}/benchmarks"

shopt -s nullglob

for benchmark_set in automatic manual_checked; do
    benchmark_dir="${BENCHMARK_ROOT}/${benchmark_set}"
    if [ ! -d "${benchmark_dir}" ]; then
        continue
    fi

    rm -rf "${benchmark_dir}/volatility_results"
    for dir in "${benchmark_dir}"/case_*/; do
        rm -rf "${dir}"/.discopop_* \
               "${dir}"/a.out \
               "${dir}"/a.out.dSYM

        rm -f "${dir}"/no_sampling_* \
              "${dir}"/sampling_* \
              "${dir}"/output_* \
              "${dir}"/batch* \
              "${dir}"/.dp_skip*
    done
done