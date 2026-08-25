#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 056 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - one of eight unrolled read instructions
//   Sink   (write): stable   - one write instruction
// Idea:
//   A single write instruction fills the selected array element, and the
//   element is read back by one of eight textually distinct instructions.
//   Address and sink stay fixed for a given repetition, isolating source
//   volatility from every other effect.
// Expected result:
//   VOLATILE. Individual read instructions are expected to drop out of
//   the sampled set.
// ============================================================

int main() {
    int arr[8];
    for (int i = 0; i < 8; ++i) {
        arr[i] = 0;
    }

    int k = rand() % 8;
    arr[k] = 60 + k;                        // Sink

    int consumed = 0;
    switch (k) {
        case 0: consumed = arr[k] + 0; break;   // Source (variant 0)
        case 1: consumed = arr[k] + 1; break;   // Source (variant 1)
        case 2: consumed = arr[k] + 2; break;   // Source (variant 2)
        case 3: consumed = arr[k] + 3; break;   // Source (variant 3)
        case 4: consumed = arr[k] + 4; break;   // Source (variant 4)
        case 5: consumed = arr[k] + 5; break;   // Source (variant 5)
        case 6: consumed = arr[k] + 6; break;   // Source (variant 6)
        default: consumed = arr[k] + 7; break;  // Source (variant 7)
    }
    (void) consumed;
}
