#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 005 - Volatility split 1: no volatility
//   Source (read) : stable  - one direct scalar read
//   Sink   (write): stable  - one direct scalar write
// Idea:
//   Single write/read pair on one scalar.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH.
// ============================================================

int main() {
    int value;
    value = 13;         // Sink
    int x = value;      // Source
    (void) x;
}
