#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 024 - Volatility split 1: no volatility
//   Source (read) : stable  - one read of the observed variable
//   Sink   (write): stable  - one write of the observed variable
// Idea:
//   Randomness is present and even controls a branch, but it only feeds
//   an unrelated scratch variable. The dependency under observation is
//   completely outside the influence of the random choice.
//   Trap case: non-determinism in the program is not volatility of a
//   dependency.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH.
// ============================================================

int main() {
    int observed = 0;
    int scratch = 0;

    if (rand() % 2 == 0) {
        scratch = 1;
    } else {
        scratch = 2;
    }

    observed = 8;               // Sink
    int x = observed;           // Source
    (void) x;
    (void) scratch;
}
