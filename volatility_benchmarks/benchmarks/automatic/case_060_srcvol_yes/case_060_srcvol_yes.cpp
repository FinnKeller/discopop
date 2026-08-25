#include <stdio.h>

// ============================================================
// Case 060 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - bulk scan plus a rare extra read
//   Sink   (write): stable   - one write instruction in the fill loop
// Idea:
//   Besides the regular scan, one cell is read by an extra instruction
//   on a few ticks only. That extra read is a distinct key in the
//   dependency file that appears three times in a hundred repetitions.
// Expected result:
//   VOLATILE. The rare extra read instruction is expected to be absent
//   from the sampled dependency set for at least one batch size.
// ============================================================

int main() {
    static int tick = 0;
    int arr[16];

    for (int i = 0; i < 16; ++i) {
        arr[i] = i + 5;                 // Sink
    }

    int total = 0;
    for (int i = 0; i < 16; ++i) {
        total += arr[i];                // Source (bulk)
    }

    if (tick % 37 == 11) {
        total += arr[7] * 10;           // Source (rare extra read)
    }

    tick = tick + 1;
    (void) total;
}
