#include <stdlib.h>

// ==========================================================
// Case 154 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a const reference parameter
//   Sink   (write): stable  - an assignment two call levels down
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a malloc'ed cell released per
//   repetition. The write is an assignment two call levels down and
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

static void store_inner(unsigned int* target) {
    *target = 43;        // Sink
}

static void store_outer(unsigned int* target) {
    store_inner(target);
}

static unsigned int load_ref(const unsigned int& source) {
    return source;        // Source
}

int main() {
    unsigned int* cell = (unsigned int*) malloc(sizeof(unsigned int));
    *cell = 0;
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    store_outer(cell);
    unsigned int observed = load_ref(*cell);
    (void) observed;
    free(cell);
}
