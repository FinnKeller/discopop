#include <stdio.h>

// ============================================================
// Case 030 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a single read instruction
//   Sink   (write): VOLATILE - one of seven switch arms
// Idea:
//   A switch statement over a rotating index gives seven distinct write
//   instructions for the same variable. Unlike the skewed chain of case
//   029 the distribution is uniform, so this measures whether seven
//   moderately frequent variants can all survive sampling.
// Expected result:
//   VOLATILE. At least one of the seven write lines is expected to be
//   missing for at least one batch size.
// ============================================================

int main() {
    static int tick = 0;
    int slot = 0;

    switch (tick % 7) {
        case 0: slot = 10; break;       // Sink (arm 0)
        case 1: slot = 11; break;       // Sink (arm 1)
        case 2: slot = 12; break;       // Sink (arm 2)
        case 3: slot = 13; break;       // Sink (arm 3)
        case 4: slot = 14; break;       // Sink (arm 4)
        case 5: slot = 15; break;       // Sink (arm 5)
        default: slot = 16; break;      // Sink (arm 6)
    }

    int x = slot;                       // Source
    tick = tick + 1;
    (void) x;
}
