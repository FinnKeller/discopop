#include <stdlib.h>

// ==========================================================
// Case 422 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read through a const reference parameter
//   Sink   (write): VOLATILE - two lambdas, the second one invoked only rarely
// Idea:
//   The sink end offers more than one candidate write instruction: two
//   lambdas, the second one invoked only rarely. The gate tick % 19 ==
//   12 fires on about 5 of the 100 repetitions, so the write line
//   inside the rare lambda gets very few chances to fall inside a
//   profiling window. The read end is a single instruction - a read
//   through a const reference parameter over a stack array element
//   whose index is drawn once and shared by both ends - so only the
//   write end of the dependency can change identity. Distance lever:
//   2560 padding writes, which guarantee a shadow memory clear for
//   every batch size.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare lambda is expected to be the first edge to
//   disappear from the sampled dependency set, which leaves the same
//   read instruction paired with a smaller set of write instructions
//   than in the baseline.
// ==========================================================

static int pad_area[64];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
            pad_area[i] = r ^ i;
        }
    }
}

static long long load_ref(const long long& source) {
    return source;        // Source
}

int main() {
    static int tick = 0;
    long long arr[16];
    int idx = rand() % 16;
    auto store_common = [](long long* target) { *target = 42; };   // Sink (frequent)
    auto store_rare = [](long long* target) { *target = 49; };   // Sink (rare)
    if (tick % 19 == 12) {
        store_rare(&arr[idx]);
    } else {
        store_common(&arr[idx]);
    }
    pad_writes(40);
    long long observed = load_ref(arr[idx]);
    tick = tick + 1;
    (void) observed;
}
