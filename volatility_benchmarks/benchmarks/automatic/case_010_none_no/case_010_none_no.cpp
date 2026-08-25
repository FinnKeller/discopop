#include <stdio.h>

// ============================================================
// Case 010 - Volatility split 1: no volatility
//   Source (read) : stable  - one read instruction in the walk loop
//   Sink   (write): stable  - one write instruction in the walk loop
// Idea:
//   Walk a pointer over an array with a fixed stride of two, writing and
//   reading through the walking pointer. The visited addresses change
//   but the instruction pair stays the same, and the pattern repeats
//   often enough to be observed in any on-window.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH.
// ============================================================

int main() {
    int arr[12];
    for (int i = 0; i < 12; ++i) {
        arr[i] = 0;
    }
    int total = 0;
    for (int* p = arr; p < arr + 12; p += 2) {
        *p = 5;                 // Sink
        total += *p;            // Source
    }
    (void) total;
}
