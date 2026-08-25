#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 031 - Volatility split 2: sink volatile only
//   Source (read) : stable   - one read of the selected element
//   Sink   (write): VOLATILE - one of eight unrolled write instructions
// Idea:
//   The same array element is written by eight textually different
//   instructions, chosen by a random index. Writing arr[k] through eight
//   distinct lines decouples the address from the instruction identity,
//   which isolates sink volatility from any address effect.
// Expected result:
//   VOLATILE. Individual write lines are expected to drop out of the
//   sampled set.
// ============================================================

int main() {
    int arr[8];
    for (int i = 0; i < 8; ++i) {
        arr[i] = 0;
    }

    int k = rand() % 8;
    switch (k) {
        case 0: arr[k] = 70; break;     // Sink (variant 0)
        case 1: arr[k] = 71; break;     // Sink (variant 1)
        case 2: arr[k] = 72; break;     // Sink (variant 2)
        case 3: arr[k] = 73; break;     // Sink (variant 3)
        case 4: arr[k] = 74; break;     // Sink (variant 4)
        case 5: arr[k] = 75; break;     // Sink (variant 5)
        case 6: arr[k] = 76; break;     // Sink (variant 6)
        default: arr[k] = 77; break;    // Sink (variant 7)
    }

    int x = arr[k];                     // Source
    (void) x;
}
