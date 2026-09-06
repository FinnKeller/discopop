#include <stdio.h>

// ============================================================
// Case 009 - Volatility split 1: no volatility
//   Source (read) : stable  - one read via fixed-offset pointer
//   Sink   (write): stable  - one write via fixed-offset pointer
// Idea:
//   Fixed-offset pointer arithmetic over one array element.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH.
// ============================================================

int main() {
    int data[4];
    int* p = data + 2;
    *p = 17;            // Sink
    int x = *p;         // Source
    (void)x;
}
