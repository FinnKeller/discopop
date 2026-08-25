#include <stdio.h>

// ============================================================
// Case 012 - Volatility split 1: no volatility
//   Source (read) : stable  - one read inside the single callee
//   Sink   (write): stable  - one write in main
// Idea:
//   Mirror image of case 011: the *read* side crosses the function
//   boundary while the write stays in main. Only one reader exists, so
//   the source end cannot move.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH.
// ============================================================

int load(const int* source) {
    return *source;         // Source
}

int main() {
    int a = 0;
    a = 44;                 // Sink
    int x = load(&a);
    (void) x;
}
