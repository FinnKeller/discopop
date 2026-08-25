#include <stdio.h>

// ============================================================
// Case 016 - Volatility split 1: no volatility
//   Source (read) : stable  - one read instruction in the traversal
//   Sink   (write): stable  - one write instruction in the build phase
// Idea:
//   Build a three node linked list on the stack, then traverse it. Every
//   payload dependency uses the same build line and the same traversal
//   line; only the node addresses differ. Pointer-chasing without any
//   runtime choice of which node is written.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH.
// ============================================================

struct Node {
    int value;
    Node* next;
};

int main() {
    Node n0;
    Node n1;
    Node n2;
    n0.next = &n1;
    n1.next = &n2;
    n2.next = 0;

    Node* cursor = &n0;
    int counter = 0;
    while (cursor != 0) {
        cursor->value = counter;    // Sink
        counter = counter + 1;
        cursor = cursor->next;
    }

    int total = 0;
    cursor = &n0;
    while (cursor != 0) {
        total += cursor->value;     // Source
        cursor = cursor->next;
    }
    (void) total;
}
