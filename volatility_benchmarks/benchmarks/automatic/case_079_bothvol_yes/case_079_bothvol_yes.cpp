#include <stdio.h>

// ============================================================
// Case 079 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - one of four read instructions, skewed
//   Sink   (write): VOLATILE - one of four write instructions, skewed
// Idea:
//   Skewed distributions on both ends, driven by two different moduli so
//   the two choices are effectively uncorrelated. The tail edges combine
//   two rare ends and are extremely unlikely to survive sampling.
// Expected result:
//   VOLATILE. The tail edges are expected to vanish first, the head edge
//   should survive.
// ============================================================

int main() {
    static int tick = 0;

    int write_weight = tick % 23;
    int read_weight = (tick * 5) % 19;

    int shared = 0;
    if (write_weight < 12) {
        shared = 1;                     // Sink (arm 0, dominant)
    } else if (write_weight < 18) {
        shared = 2;                     // Sink (arm 1)
    } else if (write_weight < 22) {
        shared = 3;                     // Sink (arm 2)
    } else {
        shared = 4;                     // Sink (arm 3, rare)
    }

    int consumed = 0;
    if (read_weight < 10) {
        consumed = shared + 1;          // Source (arm 0, dominant)
    } else if (read_weight < 15) {
        consumed = shared + 2;          // Source (arm 1)
    } else if (read_weight < 18) {
        consumed = shared + 3;          // Source (arm 2)
    } else {
        consumed = shared + 4;          // Source (arm 3, rare)
    }

    tick = tick + 1;
    (void) consumed;
}
