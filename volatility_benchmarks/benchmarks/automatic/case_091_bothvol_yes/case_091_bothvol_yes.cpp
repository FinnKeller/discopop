#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 091 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - traversal read or direct node read
//   Sink   (write): VOLATILE - traversal write or direct node write
// Idea:
//   The payload of a list node is written either by the construction loop
//   or by a direct assignment, and read either by the traversal loop or
//   by a direct read. Pointer chasing with an ambiguous instruction on
//   both ends.
// Expected result:
//   VOLATILE. Several of the four combinations are expected to be missing
//   under sampling.
// ============================================================

struct Slot {
    int payload;
    Slot* next;
};

int main() {
    Slot head;
    Slot tail;
    head.next = &tail;
    tail.next = 0;
    head.payload = 0;
    tail.payload = 0;

    if (rand() % 2 == 0) {
        Slot* cursor = &head;
        int counter = 1;
        while (cursor != 0) {
            cursor->payload = counter;      // Sink (traversal write)
            counter = counter + 1;
            cursor = cursor->next;
        }
    } else {
        tail.payload = 9;                  // Sink (direct write)
    }

    int total = 0;
    if (rand() % 2 == 0) {
        Slot* cursor = &head;
        while (cursor != 0) {
            total += cursor->payload;      // Source (traversal read)
            cursor = cursor->next;
        }
    } else {
        total += tail.payload;             // Source (direct read)
    }
    (void) total;
}
