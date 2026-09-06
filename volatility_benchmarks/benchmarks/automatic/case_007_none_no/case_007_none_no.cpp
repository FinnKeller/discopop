#include <stdio.h>

// ============================================================
// Case 007 - Volatility split 1: no volatility
//   Source (read) : stable  - one fixed array read
//   Sink   (write): stable  - one fixed array write
// Idea:
//   Constant-index array access with one write and one read.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Even if whole loop iterations
//   fall into off-windows, the surviving ones report the same edge.
// ============================================================

int main() {
    int arr[8];
    arr[3] = 21;            // Sink
    int x = arr[3];         // Source
    (void)x;
}
