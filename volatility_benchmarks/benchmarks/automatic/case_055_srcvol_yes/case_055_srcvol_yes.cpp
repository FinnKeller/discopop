#include <stdio.h>

// ============================================================
// Case 055 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - bulk read plus a special case read
//   Sink   (write): stable   - a single write instruction in the fill loop
// Idea:
//   The array is filled by one instruction and scanned by a loop that
//   uses a separate read instruction for a single index. The special
//   read therefore accounts for one sixteenth of the read traffic on
//   that address and is the fragile source variant.
// Expected result:
//   VOLATILE. The special case read instruction is expected to be lost
//   for at least one batch size while the bulk read survives.
// ============================================================

int main() {
    int arr[16];
    for (int i = 0; i < 16; ++i) {
        arr[i] = i + 1;                 // Sink
    }

    int total = 0;
    for (int i = 0; i < 16; ++i) {
        if (i == 9) {
            total += arr[i] * 3;        // Source (special index)
        } else {
            total += arr[i];            // Source (bulk)
        }
    }
    (void) total;
}
