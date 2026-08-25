#include <stdio.h>

// ============================================================
// Case 084 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - bulk scan plus a rare extra read
//   Sink   (write): VOLATILE - bulk fill plus a rare patch write
// Idea:
//   Both ends consist of a frequent bulk instruction and a rare extra
//   instruction, with different periods. Four edge classes result, from
//   bulk/bulk which is safe to rare/rare which practically never gets a
//   chance to be sampled.
// Expected result:
//   VOLATILE. The edges involving a rare instruction are expected to be
//   lost for at least one batch size.
// ============================================================

int main() {
    static int tick = 0;
    int arr[16];

    for (int i = 0; i < 16; ++i) {
        arr[i] = i;                     // Sink (bulk)
    }

    if (tick % 29 == 5) {
        arr[6] = 600;                   // Sink (rare patch)
    }

    int total = 0;
    for (int i = 0; i < 16; ++i) {
        total += arr[i];                // Source (bulk)
    }

    if (tick % 31 == 17) {
        total += arr[6] * 3;            // Source (rare extra read)
    }

    tick = tick + 1;
    (void) total;
}
