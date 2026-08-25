#include <stdio.h>

// ============================================================
// Case 018 - Volatility split 1: no volatility
//   Source (read) : stable  - one read instruction in the scan loop
//   Sink   (write): stable  - one write instruction in the fill loop
// Idea:
//   A dynamically allocated array is filled and then scanned. The buffer
//   is freshly allocated in every repetition, so all addresses move, but
//   the instruction pair is invariant. Larger access volume than the
//   stack variants, which pushes the accesses across several sampling
//   windows without changing the dependency set.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH.
// ============================================================

int main() {
    const int count = 64;
    int* buffer = new int[count];

    for (int i = 0; i < count; ++i) {
        buffer[i] = i + 1;              // Sink
    }

    int total = 0;
    for (int i = 0; i < count; ++i) {
        total += buffer[i];             // Source
    }

    delete[] buffer;
    (void) total;
}
