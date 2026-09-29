#include <stdlib.h>

// ==========================================================
// Case 404 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read inside a function template instance
//   Sink   (write): VOLATILE - a recursive writer that rarely stops one level early, at a different write line
// Idea:
//   The sink end offers more than one candidate write instruction: a
//   recursive writer that rarely stops one level early, at a different
//   write line. The gate tick % 29 == 9 fires on about 3 of the 100
//   repetitions, so the shallow stop write line gets very few chances
//   to fall inside a profiling window. The read end is a single
//   instruction - a read inside a function template instance over a
//   malloc'ed cell released per repetition - so only the write end of
//   the dependency can change identity. Distance lever: 2560 padding
//   reads, which shift the window phase from repetition to repetition.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The shallow stop
//   write line is expected to be the first edge to disappear from the
//   sampled dependency set, which leaves the same read instruction
//   paired with a smaller set of write instructions than in the
//   baseline.
// ==========================================================

static void store_descend(short* target, int depth, int shallow) {
    if (shallow != 0 && depth == 1) {
        *target = 39;               // Sink (rare shallow stop)
        return;
    }
    if (depth == 0) {
        *target = 32;               // Sink (bottom of recursion)
        return;
    }
    store_descend(target, depth - 1, shallow);
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

template <typename V>
static V load_generic(const V* source) {
    return *source;        // Source
}

int main() {
    static int tick = 0;
    short* cell = (short*) malloc(sizeof(short));
    *cell = 0;
    int sink_shallow = (tick % 29 == 9) ? 1 : 0;
    store_descend(cell, 3, sink_shallow);
    int pad_noise = pad_reads(40);
    (void) pad_noise;
    short observed = load_generic<short>(cell);
    tick = tick + 1;
    (void) observed;
    free(cell);
}
