#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 059 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - pointer walk or subscript loop
//   Sink   (write): stable   - one write instruction in the fill loop
// Idea:
//   Two loop idioms read the same buffer: a walking pointer and an
//   indexed loop. Both touch exactly the same addresses in the same
//   order, so the only difference is the identity of the source
//   instruction.
// Expected result:
//   VOLATILE. One of the two reading idioms is expected to be missing
//   for at least one batch size.
// ============================================================

int main() {
    int arr[12];
    for (int i = 0; i < 12; ++i) {
        arr[i] = i * i;                 // Sink
    }

    int total = 0;
    if (rand() % 2 == 0) {
        for (int* p = arr; p < arr + 12; ++p) {
            total += *p;                // Source (pointer walk)
        }
    } else {
        for (int i = 0; i < 12; ++i) {
            total += arr[i];            // Source (subscript loop)
        }
    }
    (void) total;
}
