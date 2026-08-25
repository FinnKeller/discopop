#include <stdio.h>

// ============================================================
// Case 054 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - one of five read instructions, skewed
//   Sink   (write): stable   - a single write instruction
// Idea:
//   A skewed if/else-if chain on the read side. The first arm dominates
//   and the last arms are rare, so the rare read keys are the natural
//   candidates for being lost while the frequent one always survives.
// Expected result:
//   VOLATILE. The rarely taken read instructions are expected to vanish
//   from the sampled dependency set.
// ============================================================

int main() {
    static int tick = 0;

    int shared = 0;
    shared = 51;                        // Sink

    int weight = tick % 31;
    int consumed = 0;

    if (weight < 16) {
        consumed = shared + 1;          // Source (arm 0, very frequent)
    } else if (weight < 24) {
        consumed = shared + 2;          // Source (arm 1)
    } else if (weight < 28) {
        consumed = shared + 3;          // Source (arm 2)
    } else if (weight < 30) {
        consumed = shared + 4;          // Source (arm 3, rare)
    } else {
        consumed = shared + 5;          // Source (arm 4, very rare)
    }

    tick = tick + 1;
    (void) consumed;
}
