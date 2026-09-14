#include <stdlib.h>

// ==========================================================
// Case 378 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read through a local pointer
//   Sink   (write): VOLATILE - a frequent write plus a rare patch write
// Idea:
//   The sink end offers more than one candidate write instruction: a
//   frequent write plus a rare patch write. The gate tick % 41 == 23
//   fires on about 2 of the 100 repetitions, so the patch write line
//   gets very few chances to fall inside a profiling window. The read
//   end is a single instruction - a read through a local pointer over
//   a stack array element whose index is drawn once and shared by both
//   ends - so only the write end of the dependency can change
//   identity. Distance lever: 2560 padding writes, which guarantee a
//   shadow memory clear for every batch size.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The patch write line
//   is expected to be the first edge to disappear from the sampled
//   dependency set, which leaves the same read instruction paired with
//   a smaller set of write instructions than in the baseline.
// ==========================================================

static int pad_area[64];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
            pad_area[i] = r ^ i;
        }
    }
}

int main() {
    static int tick = 0;
    char arr[16];
    int idx = rand() % 16;
    arr[idx] = 28;                       // Sink (frequent)
    if (tick % 41 == 23) {
        arr[idx] = 35;                   // Sink (rare patch)
    }
    pad_writes(40);
    const char* src_ptr = &arr[idx];
    char observed = *src_ptr;        // Source
    tick = tick + 1;
    (void) observed;
}
