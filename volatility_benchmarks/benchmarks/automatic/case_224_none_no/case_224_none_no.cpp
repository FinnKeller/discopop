#include <stdlib.h>

// ==========================================================
// Case 224 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a local pointer
//   Sink   (write): stable  - an assignment through a reference parameter
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a heap cell whose address moves
//   every repetition. The write is an assignment through a reference
//   parameter and the read is a read through a local pointer. Added
//   noise: a random branch that only ever touches an unrelated scratch
//   variable. Nothing in the program can make a different instruction
//   take either end of the dependency, so the reported dependency
//   structure cannot depend on which accesses a sampling window
//   happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_ref(int& target) {
    target = 32;        // Sink
}

int main() {
    int* cell = new int(0);
    int scratch = 0;
    if (rand() % 2 == 0) { scratch = 1; } else { scratch = 2; }
    (void) scratch;
    store_ref(*cell);
    const int* src_ptr = cell;
    int observed = *src_ptr;        // Source
    (void) observed;
}
