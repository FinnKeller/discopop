#include <stdio.h>

// ============================================================
// Case 025 - Volatility split 1: no volatility
//   Source (read) : stable  - one read per branch, each on its own variable
//   Sink   (write): stable  - one write per branch, each on its own variable
// Idea:
//   A branch alternates between two arms across the repetitions, so both
//   arms are exercised. The arms do not share a variable, so neither
//   dependency ever changes its endpoints; the alternation only changes
//   how often each edge is reported.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both arms are taken about fifty
//   times, so both edges are certain to land inside on-windows.
// ============================================================

int main() {
    static int tick = 0;
    int even_slot = 0;
    int odd_slot = 0;

    if (tick % 2 == 0) {
        even_slot = 3;              // Sink (even arm)
        int x = even_slot;          // Source (even arm)
        (void) x;
    } else {
        odd_slot = 4;               // Sink (odd arm)
        int y = odd_slot;           // Source (odd arm)
        (void) y;
    }

    tick = tick + 1;
}
