#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd ..
pip install ./profiler --config-settings="cmake.args=-DDP_INTERNAL_TIMER=1;-DDP_NUM_WORKERS=0;-DDP_NAIVE_SAMPLING=0" -v
cd volatility_benchmarks/benchmarks
echo no sampling!
for dir in case_*; do
    if [ -d "$dir" ]; then
        cd "$dir"
        rm -rf .discopop/ a.out a.out.dSYM
        echo ${dir}
        ../../../venv/bin/discopop_cxx "${dir}.cpp" -o a.out
        ./a.out
        mv .discopop/profiler/dynamic_dependencies.txt "no_sampling_${dir}.txt"
        cp -r .discopop .discopop_no_sampling
        cd ..
    fi
done
cd ../..
pip install ./profiler --config-settings="cmake.args=-DDP_INTERNAL_TIMER=1;-DDP_NUM_WORKERS=0;-DDP_NAIVE_SAMPLING=1" -v
cd volatility_benchmarks/benchmarks
echo sampling!
for dir in case_*; do
    if [ -d "$dir" ]; then
        cd "$dir"
        rm -rf .discopop/ a.out a.out.dSYM
        echo ${dir}
        ../../../venv/bin/discopop_cxx "${dir}.cpp" -o a.out
        ./a.out
        mv .discopop/profiler/dynamic_dependencies.txt "sampling_${dir}.txt"
        cp -r .discopop .discopop_sampling
        rm -rf .discopop
        cd ..
    fi
done
cd ..
cd benchmarks
for dir in case_*; do
    if [ -d "$dir" ]; then
        cd "$dir"
        echo "Running comparison for ${dir}"
        python3 "${SCRIPT_DIR}/comparison_volatility_cases.py" "no_sampling_${dir}.txt" "sampling_${dir}.txt" "${dir}"
        cd ..
    fi
done