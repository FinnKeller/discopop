#include <stdlib.h>

// ==========================================================
// Case 387 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read through a const reference parameter
//   Sink   (write): VOLATILE - two lambdas, the second one invoked only rarely
// Idea:
//   The sink end offers more than one candidate write instruction: two
//   lambdas, the second one invoked only rarely. The gate tick % 23 ==
//   4 fires on about 4 of the 100 repetitions, so the write line
//   inside the rare lambda gets very few chances to fall inside a
//   profiling window. The read end is a single instruction - a read
//   through a const reference parameter over a malloc'ed cell released
//   per repetition - so only the write end of the dependency can
//   change identity. No distance lever is used; rarity alone carries
//   the case.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare lambda is expected to be the first edge to
//   disappear from the sampled dependency set, which leaves the same
//   read instruction paired with a smaller set of write instructions
//   than in the baseline.
// ==========================================================

static unsigned int load_ref(const unsigned int& source) {
    return source;        // Source
}

int main() {
    static int tick = 0;
    unsigned int* cell = (unsigned int*) malloc(sizeof(unsigned int));
    *cell = 0;
    auto store_common = [](unsigned int* target) { *target = 27; };   // Sink (frequent)
    auto store_rare = [](unsigned int* target) { *target = 34; };   // Sink (rare)
    if (tick % 23 == 4) {
        store_rare(cell);
    } else {
        store_common(cell);
    }
    unsigned int observed = load_ref(*cell);
    tick = tick + 1;
    (void) observed;
    free(cell);
}
