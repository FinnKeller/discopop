#include <stdlib.h>

// ==========================================================
// Case 203 - Volatility split 1: no volatility
//   Source (read) : stable  - a read two call levels down
//   Sink   (write): stable  - an assignment through a local pointer
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over one element of a stack array. The
//   write is an assignment through a local pointer and the read is a
//   read two call levels down. Added noise: a random branch that only
//   ever touches an unrelated scratch variable. Nothing in the program
//   can make a different instruction take either end of the
//   dependency, so the reported dependency structure cannot depend on
//   which accesses a sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static long long load_inner(const long long* source) {
    return *source;        // Source
}

static long long load_outer(const long long* source) {
    return load_inner(source);
}

int main() {
    long long arr[16];
    int scratch = 0;
    if (rand() % 2 == 0) { scratch = 1; } else { scratch = 2; }
    (void) scratch;
    long long* sink_ptr = &arr[7];
    *sink_ptr = 36;        // Sink
    long long observed = load_outer(&arr[7]);
    (void) observed;
}
