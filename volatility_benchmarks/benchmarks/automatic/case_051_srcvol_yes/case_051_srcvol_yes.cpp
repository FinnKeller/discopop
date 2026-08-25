#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 051 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - one of eight read instructions
//   Sink   (write): stable   - a single write instruction
// Idea:
//   Mirror image of the sink volatile table cases. One variable is
//   written by exactly one instruction and read by one of eight, chosen
//   at runtime. Since the read is the reporting instruction, a lost
//   variant removes a whole key from the dependency file instead of just
//   one entry.
// Expected result:
//   VOLATILE. Some of the eight read instructions are expected to be
//   missing from the sampled dependency set.
// ============================================================

int main() {
    int shared = 0;
    shared = 64;                    // Sink

    int consumed = 0;
    switch (rand() % 8) {
        case 0: consumed = shared + 0; break;   // Source (variant 0)
        case 1: consumed = shared + 1; break;   // Source (variant 1)
        case 2: consumed = shared + 2; break;   // Source (variant 2)
        case 3: consumed = shared + 3; break;   // Source (variant 3)
        case 4: consumed = shared + 4; break;   // Source (variant 4)
        case 5: consumed = shared + 5; break;   // Source (variant 5)
        case 6: consumed = shared + 6; break;   // Source (variant 6)
        default: consumed = shared + 7; break;  // Source (variant 7)
    }
    (void) consumed;
}
