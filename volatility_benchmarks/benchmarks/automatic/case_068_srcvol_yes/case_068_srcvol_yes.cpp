#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 068 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - one read instruction per alias
//   Sink   (write): stable   - one write instruction in the fill loop
// Idea:
//   Two aliases refer to the same heap buffer and each alias has its own
//   read instruction. The heap address changes every repetition, so the
//   only stable information is the instruction pair, whose source half
//   is chosen at runtime.
// Expected result:
//   VOLATILE. One of the two alias read instructions is expected to be
//   lost from the sampled dependency set.
// ============================================================

int main() {
    int* buffer = new int[8];
    int* alias = buffer;

    for (int i = 0; i < 8; ++i) {
        buffer[i] = i + 1;              // Sink
    }

    int total = 0;
    if (rand() % 2 == 0) {
        for (int i = 0; i < 8; ++i) {
            total += buffer[i];         // Source (primary alias)
        }
    } else {
        for (int i = 0; i < 8; ++i) {
            total += alias[i];          // Source (secondary alias)
        }
    }

    delete[] buffer;
    (void) total;
}
