#include <stdio.h>

// ============================================================
// Case 002 - Volatility split 1: no volatility
//   Source (read) : stable  - one read through the reference
//   Sink   (write): stable  - one write through the reference
// Idea:
//   Access a scalar through a C++ reference instead of a pointer. The
//   reference is bound once at compile time, so no runtime decision can
//   move either end of the dependency to a different instruction.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH.
// ============================================================

int main() {
    int a = 0;
    int& r = a;
    r = 5;          // Sink
    int x = r;      // Source
    (void) x;
}
