#include <stdio.h>

// ============================================================
// Case 035 - Volatility split 2: sink volatile only
//   Source (read) : stable   - one read instruction in the scan loop
//   Sink   (write): VOLATILE - a bulk write plus a rare patch write
// Idea:
//   All cells are filled by one bulk instruction; additionally one cell
//   is patched by a second instruction on three of the hundred ticks.
//   The patch edge is the rare distinct edge, and the bulk edge is the
//   frequent one, so the two behave very differently under sampling.
// Expected result:
//   VOLATILE. The patch write line is expected to be absent from the
//   sampled dependency set for at least one batch size.
// ============================================================

int main() {
    static int tick = 0;
    int arr[16];

    for (int i = 0; i < 16; ++i) {
        arr[i] = i;                     // Sink (bulk)
    }

    if (tick % 37 == 11) {
        arr[13] = 999;                  // Sink (rare patch)
    }

    int total = 0;
    for (int i = 0; i < 16; ++i) {
        total += arr[i];                // Source
    }

    tick = tick + 1;
    (void) total;
}
