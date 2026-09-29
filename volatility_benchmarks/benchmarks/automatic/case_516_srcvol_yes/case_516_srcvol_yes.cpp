#include <stdlib.h>

// ==========================================================
// Case 516 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - two read instructions in the arms of a rare/frequent branch
//   Sink   (write): stable   - an assignment through a three hop pointer chain
// Idea:
//   The source end offers more than one candidate read instruction:
//   two read instructions in the arms of a rare/frequent branch. The
//   gate tick % 29 == 9 fires on about 3 of the 100 repetitions, so
//   the rare arm read line gets very few chances to fall inside a
//   profiling window. The write end is a single instruction - an
//   assignment through a three hop pointer chain over a stack array
//   element whose index is drawn once and shared by both ends - so
//   only the read end of the dependency can change identity. Distance
//   lever: 256 padding writes, enough to cross the smaller sampling
//   windows. The padding is deliberately placed in front of the write,
//   so that no shadow memory clear can fall between write and read and
//   the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The rare arm read
//   line is expected to be the first key to vanish from the sampled
//   dependency file, which leaves the same write instruction paired
//   with a smaller set of read instructions than in the baseline.
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
    long arr[16];
    int idx = rand() % 16;
    pad_writes(8);
    long* hop_a = &arr[idx];
    long* hop_b = hop_a;
    long* hop_c = hop_b;
    *hop_c = 72;        // Sink
    long observed = 0;
    if (tick % 29 == 9) {
        observed = arr[idx] + 1;         // Source (rare arm)
    } else {
        observed = arr[idx] + 2;         // Source (frequent arm)
    }
    tick = tick + 1;
    (void) observed;
}
