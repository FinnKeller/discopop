#include <stdio.h>

// ============================================================
// Case 044 - Volatility split 2: sink volatile only
//   Source (read) : stable   - one read through a pointer to member
//   Sink   (write): VOLATILE - one write instruction per field
// Idea:
//   A pointer to member selects which field the read observes, and the
//   matching field is written by its own instruction. The read
//   instruction is textually unique because the field choice is hidden
//   inside the member pointer, so only the sink end varies.
// Expected result:
//   VOLATILE. One of the two field write lines is expected to be missing
//   for at least one batch size.
// ============================================================

struct Fields {
    int left;
    int right;
};

int main() {
    static int tick = 0;

    Fields fields;
    fields.left = 0;
    fields.right = 0;

    int Fields::*member = 0;
    if (tick % 23 == 5) {
        fields.right = 71;              // Sink (right field, rare)
        member = &Fields::right;
    } else {
        fields.left = 72;               // Sink (left field, frequent)
        member = &Fields::left;
    }

    int x = fields.*member;             // Source
    tick = tick + 1;
    (void) x;
}
