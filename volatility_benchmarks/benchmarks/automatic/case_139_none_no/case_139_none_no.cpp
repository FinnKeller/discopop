#include <stdlib.h>

// ==========================================================
// Case 139 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a const reference parameter
//   Sink   (write): stable  - an assignment through a local pointer
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a malloc'ed cell released per
//   repetition. The write is an assignment through a local pointer and
//   the read is a read through a const reference parameter. Added
//   noise: a dead store to an unrelated variable. Nothing in the
//   program can make a different instruction take either end of the
//   dependency, so the reported dependency structure cannot depend on
//   which accesses a sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static int load_ref(const int& source) {
    return source;        // Source
}

int main() {
    int* cell = (int*) malloc(sizeof(int));
    *cell = 0;
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    int* sink_ptr = cell;
    *sink_ptr = 33;        // Sink
    int observed = load_ref(*cell);
    (void) observed;
    free(cell);
}
