#include <stdlib.h>

// ==========================================================
// Case 194 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a reader function
//   Sink   (write): stable  - a plain assignment
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a malloc'ed cell released per
//   repetition. The write is a plain assignment and the read is a read
//   inside a reader function. Added noise: a dead store to an
//   unrelated variable. Nothing in the program can make a different
//   instruction take either end of the dependency, so the reported
//   dependency structure cannot depend on which accesses a sampling
//   window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static unsigned int load_value(const unsigned int* source) {
    return *source;        // Source
}

int main() {
    unsigned int* cell = (unsigned int*) malloc(sizeof(unsigned int));
    *cell = 0;
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    *cell = 34;        // Sink
    unsigned int observed = load_value(cell);
    (void) observed;
    free(cell);
}
