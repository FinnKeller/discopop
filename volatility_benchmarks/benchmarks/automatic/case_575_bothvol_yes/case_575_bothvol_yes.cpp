#include <stdlib.h>

// ==========================================================
// Case 575 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a frequent read plus a rare extra read of the same cell
//   Sink   (write): VOLATILE - a frequent write plus a rare patch write
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a frequent write plus a rare patch
//   write, gated by tick % 29 == 9. On the source side: a frequent
//   read plus a rare extra read of the same cell, gated by tick % 19
//   == 12. The two periods are coprime, so the rare write and the rare
//   read almost never coincide and the pair of endpoints wanders over
//   four combinations across the 100 repetitions. The cell itself is a
//   stack array element whose index is drawn once and shared by both
//   ends. Distance lever: 256 padding writes, enough to cross the
//   smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The patch write line
//   and the extra read line are both expected to be under-reported
//   under sampling, so both the key and the value side of the
//   dependency record change.
// ==========================================================

static int pad_area[32];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 32; ++i) {
            pad_area[i] = r ^ i;
        }
    }
}

int main() {
    static int tick = 0;
    char arr[16];
    int idx = rand() % 16;
    arr[idx] = 47;                       // Sink (frequent)
    if (tick % 29 == 9) {
        arr[idx] = 54;                   // Sink (rare patch)
    }
    pad_writes(8);
    char observed = arr[idx];              // Source (frequent)
    if (tick % 19 == 12) {
        observed += arr[idx];            // Source (rare extra read)
    }
    tick = tick + 1;
    (void) observed;
}
