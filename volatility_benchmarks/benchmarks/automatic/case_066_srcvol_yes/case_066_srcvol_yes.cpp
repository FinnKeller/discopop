#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 066 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - loop traversal or unrolled reads
//   Sink   (write): stable   - one write instruction during construction
// Idea:
//   A linked list payload is read either by a traversal loop with one
//   read instruction or by three unrolled read instructions. The set of
//   source instructions for the same three addresses therefore differs
//   between repetitions.
// Expected result:
//   VOLATILE. The unrolled read instructions are expected to be reported
//   inconsistently under sampling.
// ============================================================

struct Cell {
    int payload;
    Cell* next;
};

int main() {
    Cell a;
    Cell b;
    Cell c;
    a.next = &b;
    b.next = &c;
    c.next = 0;

    Cell* cursor = &a;
    int counter = 0;
    while (cursor != 0) {
        cursor->payload = counter;      // Sink
        counter = counter + 1;
        cursor = cursor->next;
    }

    int total = 0;
    if (rand() % 2 == 0) {
        cursor = &a;
        while (cursor != 0) {
            total += cursor->payload;   // Source (traversal)
            cursor = cursor->next;
        }
    } else {
        total += a.payload;             // Source (unrolled 0)
        total += b.payload;             // Source (unrolled 1)
        total += c.payload;             // Source (unrolled 2)
    }
    (void) total;
}
