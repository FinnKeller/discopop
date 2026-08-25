#include <stdio.h>

// ============================================================
// Case 069 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - traversal read plus a rare direct read
//   Sink   (write): stable   - one write instruction during construction
// Idea:
//   A list is always read by the traversal instruction, and on a few
//   ticks one node is additionally read directly. The rare direct read
//   is the fragile source variant while the traversal is safe.
// Expected result:
//   VOLATILE. The rare direct read instruction is expected to be absent
//   for at least one batch size.
// ============================================================

struct Link {
    int payload;
    Link* next;
};

int main() {
    static int tick = 0;

    Link first;
    Link second;
    first.next = &second;
    second.next = 0;

    Link* cursor = &first;
    int counter = 1;
    while (cursor != 0) {
        cursor->payload = counter;      // Sink
        counter = counter + 1;
        cursor = cursor->next;
    }

    int total = 0;
    cursor = &first;
    while (cursor != 0) {
        total += cursor->payload;       // Source (traversal)
        cursor = cursor->next;
    }

    if (tick % 31 == 13) {
        total += second.payload * 4;    // Source (rare direct read)
    }

    tick = tick + 1;
    (void) total;
}
