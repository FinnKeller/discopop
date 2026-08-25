#include <stdio.h>

// ============================================================
// Case 095 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - one read instruction per field, skewed
//   Sink   (write): VOLATILE - one write instruction per field, skewed
// Idea:
//   A pointer to member decides which field is observed, and both the
//   write and the read of that field have their own instruction. The
//   rare field is selected on three ticks only, so the rare edge has
//   very few chances to be sampled.
// Expected result:
//   VOLATILE. The rare field edge is expected to be absent for at least
//   one batch size.
// ============================================================

struct Bundle {
    int common_field;
    int rare_field;
};

int main() {
    static int tick = 0;

    Bundle bundle;
    bundle.common_field = 0;
    bundle.rare_field = 0;

    int consumed = 0;
    if (tick % 33 == 7) {
        bundle.rare_field = 81;                 // Sink (rare field)
        consumed = bundle.rare_field + 1;       // Source (rare field)
    } else {
        bundle.common_field = 82;               // Sink (common field)
        consumed = bundle.common_field + 2;     // Source (common field)
    }

    tick = tick + 1;
    (void) consumed;
}
