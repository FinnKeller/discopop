#include <stdlib.h>

// ==========================================================
// Case 383 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read reached through a function pointer with a single target
//   Sink   (write): VOLATILE - two writer functions, the second one called only rarely
// Idea:
//   The sink end offers more than one candidate write instruction: two
//   writer functions, the second one called only rarely. The gate tick
//   % 23 == 4 fires on about 4 of the 100 repetitions, so the write
//   line inside the rare writer gets very few chances to fall inside a
//   profiling window. The read end is a single instruction - a read
//   reached through a function pointer with a single target over a
//   malloc'ed cell released per repetition - so only the write end of
//   the dependency can change identity. Distance lever: 2560 padding
//   reads, which shift the window phase from repetition to repetition.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare writer is expected to be the first edge to
//   disappear from the sampled dependency set, which leaves the same
//   read instruction paired with a smaller set of write instructions
//   than in the baseline.
// ==========================================================

static void store_common(int* target) {
    *target = 75;                   // Sink (frequent)
}

static void store_rare(int* target) {
    *target = 82;                   // Sink (rare)
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

static int load_value(const int* source) {
    return *source;        // Source
}

int main() {
    static int tick = 0;
    int* cell = (int*) malloc(sizeof(int));
    *cell = 0;
    if (tick % 23 == 4) {
        store_rare(cell);
    } else {
        store_common(cell);
    }
    int pad_noise = pad_reads(40);
    (void) pad_noise;
    int (*src_fp)(const int*) = load_value;
    int observed = src_fp(cell);
    tick = tick + 1;
    (void) observed;
    free(cell);
}
