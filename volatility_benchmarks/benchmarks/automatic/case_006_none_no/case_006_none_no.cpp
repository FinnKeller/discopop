#include <stdio.h>

// ============================================================
// Case 006 - Volatility split 1: no volatility
//   Source (read) : stable  - one read through the advanced pointer
//   Sink   (write): stable  - one write of the same element
// Idea:
//   Pointer arithmetic with a compile-time constant offset. The base is
//   an array, the offset is fixed, so the pointer always denotes the
//   same element and both ends of the dependency are unique lines.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH.
// ============================================================

int main() {
    int arr[8];
    int* base = arr;
    int* cursor = base + 2;
    *cursor = 42;           // Sink
    int x = *cursor;        // Source
    (void) x;
}
