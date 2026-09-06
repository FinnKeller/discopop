#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 076 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - one of four read instructions
//   Sink   (write): VOLATILE - one of four write instructions
// Idea:
//   Both ends are selected independently at runtime, giving sixteen
//   possible edges for a single scalar. Each individual edge occurs in
//   roughly six of a hundred repetitions, which makes the dependency set
//   very fragile even for large sampling batches.
// Expected result:
//   VOLATILE. A substantial part of the sixteen possible edges is
//   expected to be missing from the sampled dependency set.
// ============================================================

int main() {
    int shared = 0;
    int write_mode = rand() % 4;
    int read_mode = rand() % 4;

    if (write_mode == 0) {
        shared = 1;                     // Sink (write 0)
    } else if (write_mode == 1) {
        shared = 2;                     // Sink (write 1)
    } else if (write_mode == 2) {
        shared = 3;                     // Sink (write 2)
    } else {
        shared = 4;                     // Sink (write 3)
    }

    int consumed = 0;
    if (read_mode == 0) {
        consumed = shared + 10;         // Source (read 0)
    } else if (read_mode == 1) {
        consumed = shared + 20;         // Source (read 1)
    } else if (read_mode == 2) {
        consumed = shared + 30;         // Source (read 2)
    } else {
        consumed = shared + 40;         // Source (read 3)
    }
    (void) consumed;
}
