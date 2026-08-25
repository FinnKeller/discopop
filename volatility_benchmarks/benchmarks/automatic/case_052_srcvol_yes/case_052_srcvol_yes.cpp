#include <stdio.h>

// ============================================================
// Case 052 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a frequent and a rare read instruction
//   Sink   (write): stable   - a single write instruction
// Idea:
//   Deterministic rarity on the read side. The rare reader runs on three
//   ticks only, so its key has very few chances to fall inside an
//   on-window of the read counter, while the write instruction never
//   changes.
// Expected result:
//   VOLATILE. The rare read instruction is expected to be absent from
//   the sampled dependency set for at least one batch size.
// ============================================================

int main() {
    static int tick = 0;

    int shared = 0;
    shared = 33;                    // Sink

    int consumed = 0;
    if (tick % 41 == 7) {
        consumed = shared * 2;      // Source (rare)
    } else {
        consumed = shared + 1;      // Source (frequent)
    }

    tick = tick + 1;
    (void) consumed;
}
