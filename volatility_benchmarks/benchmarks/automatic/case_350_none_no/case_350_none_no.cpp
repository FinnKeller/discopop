#include <stdlib.h>

// ==========================================================
// Case 350 - Volatility split 1: no volatility
//   Source (read) : stable  - a read reached through a function pointer with a single target
//   Sink   (write): stable  - an assignment inside a function template instance
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a malloc'ed cell released per
//   repetition. The write is an assignment inside a function template
//   instance and the read is a read reached through a function pointer
//   with a single target. Added noise: a dead store to an unrelated
//   variable. Nothing in the program can make a different instruction
//   take either end of the dependency, so the reported dependency
//   structure cannot depend on which accesses a sampling window
//   happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

template <typename V>
static void store_generic(V* target, V value) {
    *target = value;        // Sink
}

static int load_value(const int* source) {
    return *source;        // Source
}

int main() {
    int* cell = (int*) malloc(sizeof(int));
    *cell = 0;
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    store_generic<int>(cell, 43);
    int (*src_fp)(const int*) = load_value;
    int observed = src_fp(cell);
    (void) observed;
    free(cell);
}
