#include <stdlib.h>

// ==========================================================
// Case 406 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read through a const reference parameter
//   Sink   (write): VOLATILE - two writer functions, the second one called only rarely
// Idea:
//   The sink end offers more than one candidate write instruction: two
//   writer functions, the second one called only rarely. The gate tick
//   % 37 == 29 fires on about 2 of the 100 repetitions, so the write
//   line inside the rare writer gets very few chances to fall inside a
//   profiling window. The read end is a single instruction - a read
//   through a const reference parameter over a stack array element
//   whose index is drawn once and shared by both ends - so only the
//   write end of the dependency can change identity. Distance lever:
//   2560 padding reads, which shift the window phase from repetition
//   to repetition.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare writer is expected to be the first edge to
//   disappear from the sampled dependency set, which leaves the same
//   read instruction paired with a smaller set of write instructions
//   than in the baseline.
// ==========================================================

static void store_common(unsigned int* target) {
    *target = 32;                   // Sink (frequent)
}

static void store_rare(unsigned int* target) {
    *target = 39;                   // Sink (rare)
}

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

static unsigned int load_ref(const unsigned int& source) {
    return source;        // Source
}

int main() {
    static int tick = 0;
    unsigned int arr[16];
    int idx = rand() % 16;
    if (tick % 37 == 29) {
        store_rare(&arr[idx]);
    } else {
        store_common(&arr[idx]);
    }
    int pad_noise = pad_reads(40);
    (void) pad_noise;
    unsigned int observed = load_ref(arr[idx]);
    tick = tick + 1;
    (void) observed;
}
