#include <stdio.h>

// ============================================================
// Case 007 - Volatility split 1: no volatility
//   Source (read) : stable  - single read instruction in the sum loop
//   Sink   (write): stable  - single write instruction in the fill loop
// Idea:
//   Fill an array in one loop and read it in a second loop. All eight
//   RAW dependencies share the same instruction pair (fill line, sum
//   line); only the addresses differ. High access volume with a single
//   endpoint pair is the cleanest possible stable pattern.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Even if whole loop iterations
//   fall into off-windows, the surviving ones report the same edge.
// ============================================================

int main() {
    int arr[8];
    for (int i = 0; i < 8; ++i) {
        arr[i] = i;             // Sink
    }
    int sum = 0;
    for (int i = 0; i < 8; ++i) {
        sum += arr[i];          // Source
    }
    (void) sum;
}
