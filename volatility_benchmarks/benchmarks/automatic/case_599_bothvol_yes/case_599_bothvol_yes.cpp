#include <stdlib.h>

// ==========================================================
// Case 599 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a frequent read plus a rare extra read of the same cell
//   Sink   (write): VOLATILE - a frequent write plus a rare patch write
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a frequent write plus a rare patch
//   write, gated by tick % 19 == 12. On the source side: a frequent
//   read plus a rare extra read of the same cell, gated by tick % 29
//   == 19. The two periods are coprime, so the rare write and the rare
//   read almost never coincide and the pair of endpoints wanders over
//   four combinations across the 100 repetitions. The cell itself is a
//   stack array element whose index is drawn once and shared by both
//   ends. No distance lever is used; rarity on both ends carries the
//   case.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The patch write line
//   and the extra read line are both expected to be under-reported
//   under sampling, so both the key and the value side of the
//   dependency record change.
// ==========================================================

int main() {
    static int tick = 0;
    short arr[16];
    int idx = rand() % 16;
    arr[idx] = 47;                       // Sink (frequent)
    if (tick % 19 == 12) {
        arr[idx] = 54;                   // Sink (rare patch)
    }
    short observed = arr[idx];              // Source (frequent)
    if (tick % 29 == 19) {
        observed += arr[idx];            // Source (rare extra read)
    }
    tick = tick + 1;
    (void) observed;
}
