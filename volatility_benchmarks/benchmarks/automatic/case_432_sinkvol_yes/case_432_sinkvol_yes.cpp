#include <stdlib.h>

// ==========================================================
// Case 432 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read inside a function template instance
//   Sink   (write): VOLATILE - two aliases of the same cell, the second one used only rarely
// Idea:
//   The sink end offers more than one candidate write instruction: two
//   aliases of the same cell, the second one used only rarely. The
//   gate tick % 41 == 13 fires on about 2 of the 100 repetitions, so
//   the write line through the rare alias gets very few chances to
//   fall inside a profiling window. The read end is a single
//   instruction - a read inside a function template instance over a
//   malloc'ed cell released per repetition - so only the write end of
//   the dependency can change identity. Distance lever: 256 padding
//   writes, enough to cross the smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   through the rare alias is expected to be the first edge to
//   disappear from the sampled dependency set, which leaves the same
//   read instruction paired with a smaller set of write instructions
//   than in the baseline.
// ==========================================================

static int pad_area[32];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 32; ++i) {
            pad_area[i] = r ^ i;
        }
    }
}

template <typename V>
static V load_generic(const V* source) {
    return *source;        // Source
}

int main() {
    static int tick = 0;
    int* cell = (int*) malloc(sizeof(int));
    *cell = 0;
    int* sink_alias_main = cell;
    int* sink_alias_rare = cell;
    if (tick % 41 == 13) {
        *sink_alias_rare = 40;          // Sink (rare alias)
    } else {
        *sink_alias_main = 33;          // Sink (frequent alias)
    }
    pad_writes(8);
    int observed = load_generic<int>(cell);
    tick = tick + 1;
    (void) observed;
    free(cell);
}
