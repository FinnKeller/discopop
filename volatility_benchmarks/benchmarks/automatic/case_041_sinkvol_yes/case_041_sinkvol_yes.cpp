#include <stdio.h>

// ============================================================
// Case 041 - Volatility split 2: sink volatile only
//   Source (read) : stable   - one read instruction in the traversal
//   Sink   (write): VOLATILE - bulk fill plus a rare single node patch
// Idea:
//   A linked list is filled by one instruction during construction, and
//   on a few ticks one node is additionally patched by a second
//   instruction. The traversal that reads the payload is a single
//   instruction, so only the sink end can change.
// Expected result:
//   VOLATILE. The rare node patch line is expected to be absent from the
//   sampled dependency set for at least one batch size.
// ============================================================

struct Item {
    int payload;
    Item* next;
};

int main() {
    static int tick = 0;

    Item a;
    Item b;
    Item c;
    a.next = &b;
    b.next = &c;
    c.next = 0;

    Item* cursor = &a;
    int counter = 0;
    while (cursor != 0) {
        cursor->payload = counter;      // Sink (bulk)
        counter = counter + 1;
        cursor = cursor->next;
    }

    if (tick % 29 == 9) {
        b.payload = 555;                // Sink (rare patch)
    }

    int total = 0;
    cursor = &a;
    while (cursor != 0) {
        total += cursor->payload;       // Source
        cursor = cursor->next;
    }

    tick = tick + 1;
    (void) total;
}
