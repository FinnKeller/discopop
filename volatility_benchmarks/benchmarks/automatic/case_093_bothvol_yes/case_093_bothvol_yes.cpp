#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 093 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - one read instruction per heap buffer
//   Sink   (write): VOLATILE - one write instruction per heap buffer
// Idea:
//   Two heap buffers, each with its own fill and its own scan
//   instruction. The selection is made once and used by both ends, so
//   the edges are correlated pairs. Heap addresses move every
//   repetition, so instruction identity carries all the information.
// Expected result:
//   VOLATILE. At least one of the two buffer edges is expected to be
//   missing under sampling.
// ============================================================

int main() {
    int* left = new int[8];
    int* right = new int[8];
    int use_left = (rand() % 2 == 0) ? 1 : 0;

    if (use_left == 1) {
        for (int i = 0; i < 8; ++i) {
            left[i] = i + 1;            // Sink (left buffer)
        }
    } else {
        for (int i = 0; i < 8; ++i) {
            right[i] = i + 2;           // Sink (right buffer)
        }
    }

    int total = 0;
    if (use_left == 1) {
        for (int i = 0; i < 8; ++i) {
            total += left[i];           // Source (left buffer)
        }
    } else {
        for (int i = 0; i < 8; ++i) {
            total += right[i];          // Source (right buffer)
        }
    }

    delete[] left;
    delete[] right;
    (void) total;
}
