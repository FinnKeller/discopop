#include <stdlib.h>

// ==========================================================
// Case 114 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a reader function
//   Sink   (write): stable  - an assignment through a reference parameter
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a malloc'ed cell released per
//   repetition. The write is an assignment through a reference
//   parameter and the read is a read inside a reader function. Added
//   noise: a second, completely separate write/read pair on an
//   unrelated variable. Nothing in the program can make a different
//   instruction take either end of the dependency, so the reported
//   dependency structure cannot depend on which accesses a sampling
//   window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_ref(int& target) {
    target = 36;        // Sink
}

static int load_value(const int* source) {
    return *source;        // Source
}

int main() {
    int* cell = (int*) malloc(sizeof(int));
    *cell = 0;
    int companion = 0;
    companion = 271;
    int companion_seen = companion;
    (void) companion_seen;
    store_ref(*cell);
    int observed = load_value(cell);
    (void) observed;
    free(cell);
}
