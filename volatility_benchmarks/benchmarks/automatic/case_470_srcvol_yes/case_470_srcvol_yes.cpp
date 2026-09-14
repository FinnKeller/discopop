#include <stdlib.h>

// ==========================================================
// Case 470 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - two aliases of the same cell, the second one read only rarely
//   Sink   (write): stable   - an assignment inside a writer function
// Idea:
//   The source end offers more than one candidate read instruction:
//   two aliases of the same cell, the second one read only rarely. The
//   gate tick % 29 == 9 fires on about 3 of the 100 repetitions, so
//   the read line through the rare alias gets very few chances to fall
//   inside a profiling window. The write end is a single instruction -
//   an assignment inside a writer function over a malloc'ed cell
//   released per repetition - so only the read end of the dependency
//   can change identity. Distance lever: 256 padding reads, enough to
//   cross the smaller sampling windows. The padding is deliberately
//   placed in front of the write, so that no shadow memory clear can
//   fall between write and read and the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The read line
//   through the rare alias is expected to be the first key to vanish
//   from the sampled dependency file, which leaves the same write
//   instruction paired with a smaller set of read instructions than in
//   the baseline.
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

static void store_value(char* target) {
    *target = 69;        // Sink
}

int main() {
    static int tick = 0;
    char* cell = (char*) malloc(sizeof(char));
    *cell = 0;
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    store_value(cell);
    const char* src_alias_main = cell;
    const char* src_alias_rare = cell;
    char observed = 0;
    if (tick % 29 == 9) {
        observed = *src_alias_rare;    // Source (rare alias)
    } else {
        observed = *src_alias_main;    // Source (frequent alias)
    }
    tick = tick + 1;
    (void) observed;
    free(cell);
}
