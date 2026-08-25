#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 057 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - ascending or descending scan instruction
//   Sink   (write): stable   - one write instruction in the fill loop
// Idea:
//   The array is always filled by the same instruction but scanned
//   either forwards or backwards, by two different read instructions.
//   The direction also changes the order in which the addresses are
//   touched, which interacts with the sampling windows.
// Expected result:
//   VOLATILE. One of the two scan instructions is expected to be missing
//   for at least one batch size.
// ============================================================

int main() {
    int arr[20];
    for (int i = 0; i < 20; ++i) {
        arr[i] = i;                     // Sink
    }

    int total = 0;
    if (rand() % 2 == 0) {
        for (int i = 0; i < 20; ++i) {
            total += arr[i];            // Source (ascending)
        }
    } else {
        for (int i = 19; i >= 0; --i) {
            total += arr[i];            // Source (descending)
        }
    }
    (void) total;
}
