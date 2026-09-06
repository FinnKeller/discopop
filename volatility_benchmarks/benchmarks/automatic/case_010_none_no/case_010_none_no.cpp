#include <stdio.h>

// ============================================================
// Case 010 - Volatility split 1: no volatility
//   Source (read) : stable  - one read of the addressed element
//   Sink   (write): stable  - one write of the addressed element
// Idea:
//   Single pointer walk step with constant offset.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH.
// ============================================================

int main() {
    int arr[12];
    int* p = arr + 4;
    *p = 5;                 // Sink
    int x = *p;             // Source
    (void)x;
}
