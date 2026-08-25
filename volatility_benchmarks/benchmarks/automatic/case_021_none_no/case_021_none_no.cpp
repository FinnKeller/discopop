#include <stdio.h>

// ============================================================
// Case 021 - Volatility split 1: no volatility
//   Source (read) : stable  - one read through the triple indirection
//   Sink   (write): stable  - one write through the triple indirection
// Idea:
//   Three levels of pointer indirection (int***). Deep indirection makes
//   the target hard to see statically, but every level is assigned once,
//   so the dynamic target is always the same single scalar.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH.
// ============================================================

int main() {
    int value = 0;
    int* level1 = &value;
    int** level2 = &level1;
    int*** level3 = &level2;

    ***level3 = 99;             // Sink
    int x = ***level3;          // Source
    (void) x;
}
