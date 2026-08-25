#include <stdio.h>

// ============================================================
// Case 014 - Volatility split 1: no volatility
//   Source (read) : stable  - one read per variable
//   Sink   (write): stable  - one write per variable, both always executed
// Idea:
//   Two writer functions exist, as in the volatile function-pointer
//   cases, but *both* are called unconditionally on their own variable.
//   Nothing is selected at runtime, so the candidate set collapses and
//   each dependency has a fixed endpoint pair.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH.
// ============================================================

void writer_a(int* target) {
    *target = 1;            // Sink (for a)
}

void writer_b(int* target) {
    *target = 2;            // Sink (for b)
}

int main() {
    int a = 0;
    int b = 0;
    writer_a(&a);
    writer_b(&b);
    int x = a;              // Source (for a)
    int y = b;              // Source (for b)
    (void) x;
    (void) y;
}
