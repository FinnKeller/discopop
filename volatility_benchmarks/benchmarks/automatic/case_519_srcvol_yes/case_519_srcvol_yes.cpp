#include <stdlib.h>

// ==========================================================
// Case 519 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a frequent read plus a rare extra read of the same cell
//   Sink   (write): stable   - an assignment through one of two pointers that denote the same object
// Idea:
//   The source end offers more than one candidate read instruction: a
//   frequent read plus a rare extra read of the same cell. The gate
//   tick % 31 == 7 fires on about 3 of the 100 repetitions, so the
//   extra read line gets very few chances to fall inside a profiling
//   window. The write end is a single instruction - an assignment
//   through one of two pointers that denote the same object over a
//   malloc'ed cell released per repetition - so only the read end of
//   the dependency can change identity. Distance lever: 2560 padding
//   writes, which guarantee a shadow memory clear for every batch
//   size. The padding is deliberately placed in front of the write, so
//   that no shadow memory clear can fall between write and read and
//   the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The extra read line
//   is expected to be the first key to vanish from the sampled
//   dependency file, which leaves the same write instruction paired
//   with a smaller set of read instructions than in the baseline.
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
    long* cell = (long*) malloc(sizeof(long));
    *cell = 0;
    pad_writes(40);
    long* alias_a = cell;
    long* alias_b = cell;
    long* chosen = (rand() % 2 == 0) ? alias_a : alias_b;
    *chosen = 26;        // Sink
    long observed = *cell;              // Source (frequent)
    if (tick % 31 == 7) {
        observed += *cell;            // Source (rare extra read)
    }
    tick = tick + 1;
    (void) observed;
    free(cell);
}
