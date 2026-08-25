#include <stdio.h>

// ============================================================
// Case 077 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a frequent and a rare read instruction
//   Sink   (write): VOLATILE - a frequent and a rare write instruction
// Idea:
//   Deterministic rarity on both ends, with different periods so that
//   the rare write and the rare read almost never coincide. The rare
//   combination edge exists at most once in a hundred repetitions and is
//   therefore the most fragile edge in the whole benchmark set.
// Expected result:
//   VOLATILE. The edges involving a rare end are expected to be lost for
//   at least one batch size.
// ============================================================

int main() {
    static int tick = 0;

    int shared = 0;
    if (tick % 41 == 7) {
        shared = 100;                   // Sink (rare)
    } else {
        shared = 200;                   // Sink (frequent)
    }

    int consumed = 0;
    if (tick % 37 == 11) {
        consumed = shared * 2;          // Source (rare)
    } else {
        consumed = shared + 1;          // Source (frequent)
    }

    tick = tick + 1;
    (void) consumed;
}
