#include <stdio.h>

// ============================================================
// Case 029 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a single read instruction
//   Sink   (write): VOLATILE - one of five write instructions, skewed
// Idea:
//   An if/else-if chain with five write sites and a deliberately skewed
//   distribution: the last arm is reached far less often than the first.
//   Skew means the tail edges have few chances to be seen, which makes
//   the loss of a distinct edge much more likely than with a uniform
//   choice.
// Expected result:
//   VOLATILE. The rarely taken arms are the ones expected to vanish from
//   the sampled dependency set.
// ============================================================

int main() {
    static int tick = 0;
    int slot = 0;
    int weight = tick % 31;

    if (weight < 16) {
        slot = 1;                   // Sink (arm 0, very frequent)
    } else if (weight < 24) {
        slot = 2;                   // Sink (arm 1)
    } else if (weight < 28) {
        slot = 3;                   // Sink (arm 2)
    } else if (weight < 30) {
        slot = 4;                   // Sink (arm 3, rare)
    } else {
        slot = 5;                   // Sink (arm 4, very rare)
    }

    int x = slot;                   // Source
    tick = tick + 1;
    (void) x;
}
