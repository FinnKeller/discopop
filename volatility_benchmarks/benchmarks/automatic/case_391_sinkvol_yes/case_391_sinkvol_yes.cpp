#include <stdlib.h>

// ==========================================================
// Case 391 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read through a const reference parameter
//   Sink   (write): VOLATILE - two aliases of the same cell, the second one used only rarely
// Idea:
//   The sink end offers more than one candidate write instruction: two
//   aliases of the same cell, the second one used only rarely. The
//   gate tick % 37 == 29 fires on about 2 of the 100 repetitions, so
//   the write line through the rare alias gets very few chances to
//   fall inside a profiling window. The read end is a single
//   instruction - a read through a const reference parameter over a
//   stack array element whose index is drawn once and shared by both
//   ends - so only the write end of the dependency can change
//   identity. No distance lever is used; rarity alone carries the
//   case.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   through the rare alias is expected to be the first edge to
//   disappear from the sampled dependency set, which leaves the same
//   read instruction paired with a smaller set of write instructions
//   than in the baseline.
// ==========================================================

static long load_ref(const long& source) {
    return source;        // Source
}

int main() {
    static int tick = 0;
    long arr[16];
    int idx = rand() % 16;
    long* sink_alias_main = &arr[idx];
    long* sink_alias_rare = &arr[idx];
    if (tick % 37 == 29) {
        *sink_alias_rare = 55;          // Sink (rare alias)
    } else {
        *sink_alias_main = 48;          // Sink (frequent alias)
    }
    long observed = load_ref(arr[idx]);
    tick = tick + 1;
    (void) observed;
}
