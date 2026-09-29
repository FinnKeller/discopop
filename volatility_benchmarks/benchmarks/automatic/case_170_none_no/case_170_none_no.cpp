#include <stdlib.h>

// ==========================================================
// Case 170 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a function template instance
//   Sink   (write): stable  - an assignment through a reference parameter
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a malloc'ed cell released per
//   repetition. The write is an assignment through a reference
//   parameter and the read is a read inside a function template
//   instance. Added noise: a random branch that only ever touches an
//   unrelated scratch variable. Nothing in the program can make a
//   different instruction take either end of the dependency, so the
//   reported dependency structure cannot depend on which accesses a
//   sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_ref(unsigned int& target) {
    target = 41;        // Sink
}

template <typename V>
static V load_generic(const V* source) {
    return *source;        // Source
}

int main() {
    unsigned int* cell = (unsigned int*) malloc(sizeof(unsigned int));
    *cell = 0;
    int scratch = 0;
    if (rand() % 2 == 0) { scratch = 1; } else { scratch = 2; }
    (void) scratch;
    store_ref(*cell);
    unsigned int observed = load_generic<unsigned int>(cell);
    (void) observed;
    free(cell);
}
