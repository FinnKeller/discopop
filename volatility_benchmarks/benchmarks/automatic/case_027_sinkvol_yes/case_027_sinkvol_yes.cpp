#include <stdio.h>

// ============================================================
// Case 027 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a single read instruction
//   Sink   (write): VOLATILE - a frequent and a rare write instruction
// Idea:
//   Deterministic rarity instead of randomness. The common write runs in
//   almost every repetition, the rare write only on ticks 7, 48 and 89.
//   The rare edge exists in the unsampled reference but has just three
//   chances to fall inside an on-window, so it is easily lost.
// Expected result:
//   VOLATILE. The rare write line is expected to be missing from the
//   sampled dependency set for at least one batch size, while the
//   frequent write line survives.
// ============================================================

int main() {
    static int tick = 0;

    int common_slot = 0;
    int rare_slot = 0;
    int* selected = &common_slot;

    if (tick % 41 == 7) {
        rare_slot = 100;            // Sink (rare)
        selected = &rare_slot;
    } else {
        common_slot = 200;          // Sink (frequent)
    }

    int x = *selected;              // Source
    tick = tick + 1;
    (void) x;
}
