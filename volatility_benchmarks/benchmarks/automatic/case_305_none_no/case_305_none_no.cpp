#include <stdlib.h>

// ==========================================================
// Case 305 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a local pointer
//   Sink   (write): stable  - an assignment through one of two pointers that denote the same object
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a plain stack scalar. The write is
//   an assignment through one of two pointers that denote the same
//   object and the read is a read through a local pointer. Added
//   noise: a dead store to an unrelated variable. Nothing in the
//   program can make a different instruction take either end of the
//   dependency, so the reported dependency structure cannot depend on
//   which accesses a sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

int main() {
    int cell = 0;
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    int* alias_a = &cell;
    int* alias_b = &cell;
    int* chosen = (rand() % 2 == 0) ? alias_a : alias_b;
    *chosen = 33;        // Sink
    const int* src_ptr = &cell;
    int observed = *src_ptr;        // Source
    (void) observed;
}
