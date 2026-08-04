cd benchmarks || exit 1

shopt -s nullglob

for dir in case_*/; do
    rm -rf "$dir"/.discopop_* \
           "$dir"/a.out \
           "$dir"/a.out.dSYM

    rm -f "$dir"/no_sampling_* \
          "$dir"/sampling_* \
          "$dir"/output_*
done