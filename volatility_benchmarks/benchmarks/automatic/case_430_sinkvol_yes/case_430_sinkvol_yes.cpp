#include <stdlib.h>

// ==========================================================
// Case 430 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read through a const reference parameter
//   Sink   (write): VOLATILE - a frequent write plus a rare patch write
// Idea:
//   The sink end offers more than one candidate write instruction: a
//   frequent write plus a rare patch write. The gate tick % 31 == 7
//   fires on about 3 of the 100 repetitions, so the patch write line
//   gets very few chances to fall inside a profiling window. The read
//   end is a single instruction - a read through a const reference
//   parameter over a stack array element whose index is drawn once and
//   shared by both ends - so only the write end of the dependency can
//   change identity. Distance lever: 2560 padding reads, which shift
//   the window phase from repetition to repetition.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The patch write line
//   is expected to be the first edge to disappear from the sampled
//   dependency set, which leaves the same read instruction paired with
//   a smaller set of write instructions than in the baseline.
// ==========================================================

static int pad_area[64];

static int pad_reads(int rounds) {
    int sum = 0;
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
            sum += pad_area[i];
        }
    }
    return sum;
}

static long long load_ref(const long long& source) {
    return source;        // Source
}

int main() {
    static int tick = 0;
    long long arr[16];
    int idx = rand() % 16;
    arr[idx] = 27;                       // Sink (frequent)
    if (tick % 31 == 7) {
        arr[idx] = 34;                   // Sink (rare patch)
    }
    int pad_noise = pad_reads(40);
    (void) pad_noise;
    long long observed = load_ref(arr[idx]);
    tick = tick + 1;
    (void) observed;
}
