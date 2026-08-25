#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 043 - Volatility split 2: sink volatile only
//   Source (read) : stable   - one read of the selected buffer
//   Sink   (write): VOLATILE - one write instruction per heap buffer
// Idea:
//   Two heap buffers, each filled by its own instruction, and the read
//   follows whichever buffer was selected. Heap addresses move every
//   repetition, so the only stable identity is the instruction pair,
//   and that pair changes with the selection.
// Expected result:
//   VOLATILE. One of the two fill lines is expected to be lost from the
//   sampled dependency set.
// ============================================================

int main() {
    int* left = new int[8];
    int* right = new int[8];
    int* selected = 0;

    if (rand() % 2 == 0) {
        for (int i = 0; i < 8; ++i) {
            left[i] = i;                // Sink (left buffer)
        }
        selected = left;
    } else {
        for (int i = 0; i < 8; ++i) {
            right[i] = i * 3;           // Sink (right buffer)
        }
        selected = right;
    }

    int total = 0;
    for (int i = 0; i < 8; ++i) {
        total += selected[i];           // Source
    }

    delete[] left;
    delete[] right;
    (void) total;
}
