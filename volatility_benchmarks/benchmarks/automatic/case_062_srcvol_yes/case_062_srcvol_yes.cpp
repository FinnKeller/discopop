#include <stdio.h>

// ============================================================
// Case 062 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a frequent and a rare reader function
//   Sink   (write): stable   - one write instruction in main
// Idea:
//   Cross-procedural source volatility combined with deterministic
//   rarity: the rare reader is called on two ticks only, so its
//   dependency key barely has a chance to be sampled.
// Expected result:
//   VOLATILE. The rare reader's instruction is expected to be lost for
//   at least one batch size.
// ============================================================

int frequent_reader(const int* source) {
    return *source + 1;             // Source (frequent)
}

int rare_reader(const int* source) {
    return *source + 2;             // Source (rare)
}

int main() {
    static int tick = 0;

    int a = 0;
    a = 62;                         // Sink

    int x = 0;
    if (tick % 47 == 19) {
        x = rare_reader(&a);
    } else {
        x = frequent_reader(&a);
    }

    tick = tick + 1;
    (void) x;
}
