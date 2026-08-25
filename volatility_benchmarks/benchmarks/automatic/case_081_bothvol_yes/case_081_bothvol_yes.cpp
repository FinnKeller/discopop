#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 081 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - one of four unrolled read instructions
//   Sink   (write): VOLATILE - one of four unrolled write instructions
// Idea:
//   The same array element is written by one of four instructions and
//   read by one of four others, both chosen independently. The address is
//   identical for all sixteen combinations, so the volatility is purely
//   about instruction identity on both ends.
// Expected result:
//   VOLATILE. Many of the sixteen edges are expected to be missing under
//   sampling.
// ============================================================

int main() {
    int arr[4];
    for (int i = 0; i < 4; ++i) {
        arr[i] = 0;
    }

    int slot = 2;
    switch (rand() % 4) {
        case 0: arr[slot] = 10; break;      // Sink (write 0)
        case 1: arr[slot] = 11; break;      // Sink (write 1)
        case 2: arr[slot] = 12; break;      // Sink (write 2)
        default: arr[slot] = 13; break;     // Sink (write 3)
    }

    int consumed = 0;
    switch (rand() % 4) {
        case 0: consumed = arr[slot]; break;        // Source (read 0)
        case 1: consumed = arr[slot] + 1; break;    // Source (read 1)
        case 2: consumed = arr[slot] * 2; break;    // Source (read 2)
        default: consumed = arr[slot] - 1; break;   // Source (read 3)
    }
    (void) consumed;
}
