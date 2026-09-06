#include <stdio.h>

// ============================================================
// Case 008 - Volatility split 1: no volatility
//   Source (read) : stable  - one read of one matrix element
//   Sink   (write): stable  - one write of the same element
// Idea:
//   Two-dimensional indexing with constant indices. Row-major address
//   computation is more work for the instrumentation, but the resulting
//   dependency is a single fixed instruction pair.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH.
// ============================================================

int main() {
    int matrix[3][3];
    matrix[1][2] = 77;              // Sink
    int x = matrix[1][2];           // Source
    (void) x;
}
