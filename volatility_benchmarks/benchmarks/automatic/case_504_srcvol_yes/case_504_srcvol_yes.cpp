#include <stdlib.h>

// ==========================================================
// Case 504 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a frequent read plus a rare extra read of the same cell
//   Sink   (write): stable   - an assignment through a local pointer
// Idea:
//   The source end offers more than one candidate read instruction: a
//   frequent read plus a rare extra read of the same cell. The gate
//   tick % 29 == 9 fires on about 3 of the 100 repetitions, so the
//   extra read line gets very few chances to fall inside a profiling
//   window. The write end is a single instruction - an assignment
//   through a local pointer over a stack array element whose index is
//   drawn once and shared by both ends - so only the read end of the
//   dependency can change identity. No distance lever is used; rarity
//   alone carries the case. The padding is deliberately placed in
//   front of the write, so that no shadow memory clear can fall
//   between write and read and the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The extra read line
//   is expected to be the first key to vanish from the sampled
//   dependency file, which leaves the same write instruction paired
//   with a smaller set of read instructions than in the baseline.
// ==========================================================

int main() {
    static int tick = 0;
    long long arr[16];
    int idx = rand() % 16;
    long long* sink_ptr = &arr[idx];
    *sink_ptr = 72;        // Sink
    long long observed = arr[idx];              // Source (frequent)
    if (tick % 29 == 9) {
        observed += arr[idx];            // Source (rare extra read)
    }
    tick = tick + 1;
    (void) observed;
}
