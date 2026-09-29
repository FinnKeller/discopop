#include <stdlib.h>

// ==========================================================
// Case 458 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - two loop shapes carrying two different read instructions
//   Sink   (write): stable   - an assignment through a three hop pointer chain
// Idea:
//   The source end offers more than one candidate read instruction:
//   two loop shapes carrying two different read instructions. The gate
//   tick % 29 == 9 fires on about 3 of the 100 repetitions, so the
//   read line of the rare loop shape gets very few chances to fall
//   inside a profiling window. The write end is a single instruction -
//   an assignment through a three hop pointer chain over a stack array
//   element whose index is drawn once and shared by both ends - so
//   only the read end of the dependency can change identity. Distance
//   lever: 256 padding reads, enough to cross the smaller sampling
//   windows. The padding is deliberately placed in front of the write,
//   so that no shadow memory clear can fall between write and read and
//   the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The read line of the
//   rare loop shape is expected to be the first key to vanish from the
//   sampled dependency file, which leaves the same write instruction
//   paired with a smaller set of read instructions than in the
//   baseline.
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
    unsigned int arr[16];
    int idx = rand() % 16;
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    unsigned int* hop_a = &arr[idx];
    unsigned int* hop_b = hop_a;
    unsigned int* hop_c = hop_b;
    *hop_c = 74;        // Sink
    unsigned int observed = 0;
    if (tick % 29 == 9) {
        for (int i = 0; i < 16; i += 1) {
            if (i == 7) { observed += arr[idx]; } // Source (rare dense loop)
        }
    } else {
        for (int i = 0; i < 16; i += 7) {
            if (i == 7) { observed += arr[idx]; } // Source (frequent sparse loop)
        }
    }
    tick = tick + 1;
    (void) observed;
}
