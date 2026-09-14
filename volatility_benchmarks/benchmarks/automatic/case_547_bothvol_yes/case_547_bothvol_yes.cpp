#include <stdlib.h>

// ==========================================================
// Case 547 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a switch over the tick counter with two rare arms and one default arm
//   Sink   (write): VOLATILE - two write instructions in the arms of a rare/frequent branch
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: two write instructions in the arms
//   of a rare/frequent branch, gated by tick % 41 == 13. On the source
//   side: a switch over the tick counter with two rare arms and one
//   default arm, gated by tick % 29 == 9. The two periods are coprime,
//   so the rare write and the rare read almost never coincide and the
//   pair of endpoints wanders over four combinations across the 100
//   repetitions. The cell itself is a stack array element whose index
//   is drawn once and shared by both ends. Distance lever: 256 padding
//   reads, enough to cross the smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The rare arm write
//   line and the two rare arm read lines are both expected to be
//   under-reported under sampling, so both the key and the value side
//   of the dependency record change.
// ==========================================================

static int pad_area[32];

static int pad_reads(int rounds) {
    int sum = 0;
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 32; ++i) {
            sum += pad_area[i];
        }
    }
    return sum;
}

int main() {
    static int tick = 0;
    int arr[16];
    int idx = rand() % 16;
    if (tick % 41 == 13) {
        arr[idx] = 65;                   // Sink (rare arm)
    } else {
        arr[idx] = 58;                   // Sink (frequent arm)
    }
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    int observed = 0;
    switch (tick % 29) {
    case 9:
        observed = arr[idx] + 1;         // Source (rare arm)
        break;
    case 10:
        observed = arr[idx] + 2;         // Source (second rare arm)
        break;
    default:
        observed = arr[idx] + 3;         // Source (default arm)
        break;
    }
    tick = tick + 1;
    (void) observed;
}
