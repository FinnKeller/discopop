#include <stdio.h>

// ============================================================
// Case 003 - Volatility split 1: no volatility
//   Source (read) : stable  - two direct scalar reads
//   Sink   (write): stable  - two direct scalar writes
// Idea:
//   Two independent scalars are written and then read directly.
//   No extra pointer bookkeeping access is involved.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both edges recur in every
//   repetition, so neither can be lost from the union.
// ============================================================

int main() {
    int a;
    int b;
    a = 11;          // Sink (for a)
    b = 22;          // Sink (for b)
    int x = a;       // Source (for a)
    int y = b;       // Source (for b)
    (void) x;
    (void) y;
}
