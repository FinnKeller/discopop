#include <stdlib.h>

// ==========================================================
// Case 484 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a switch over the tick counter with two rare arms and one default arm
//   Sink   (write): stable   - an assignment through a three hop pointer chain
// Idea:
//   The source end offers more than one candidate read instruction: a
//   switch over the tick counter with two rare arms and one default
//   arm. The gate tick % 23 == 4 fires on about 4 of the 100
//   repetitions, so the two rare arm read lines gets very few chances
//   to fall inside a profiling window. The write end is a single
//   instruction - an assignment through a three hop pointer chain over
//   a stack array element whose index is drawn once and shared by both
//   ends - so only the read end of the dependency can change identity.
//   Distance lever: 256 padding writes, enough to cross the smaller
//   sampling windows. The padding is deliberately placed in front of
//   the write, so that no shadow memory clear can fall between write
//   and read and the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The two rare arm
//   read lines is expected to be the first key to vanish from the
//   sampled dependency file, which leaves the same write instruction
//   paired with a smaller set of read instructions than in the
//   baseline.
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
    int arr[16];
    int idx = rand() % 16;
    pad_writes(8);
    int* hop_a = &arr[idx];
    int* hop_b = hop_a;
    int* hop_c = hop_b;
    *hop_c = 71;        // Sink
    int observed = 0;
    switch (tick % 23) {
    case 4:
        observed = arr[idx] + 1;         // Source (rare arm)
        break;
    case 5:
        observed = arr[idx] + 2;         // Source (second rare arm)
        break;
    default:
        observed = arr[idx] + 3;         // Source (default arm)
        break;
    }
    tick = tick + 1;
    (void) observed;
}
