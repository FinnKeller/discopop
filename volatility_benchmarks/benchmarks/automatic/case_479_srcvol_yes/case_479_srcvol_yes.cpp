#include <stdlib.h>

// ==========================================================
// Case 479 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - two aliases of the same cell, the second one read only rarely
//   Sink   (write): stable   - an assignment through one of two pointers that denote the same object
// Idea:
//   The source end offers more than one candidate read instruction:
//   two aliases of the same cell, the second one read only rarely. The
//   gate tick % 19 == 5 fires on about 5 of the 100 repetitions, so
//   the read line through the rare alias gets very few chances to fall
//   inside a profiling window. The write end is a single instruction -
//   an assignment through one of two pointers that denote the same
//   object over a translation unit global scalar - so only the read
//   end of the dependency can change identity. Distance lever: 2560
//   padding writes, which guarantee a shadow memory clear for every
//   batch size. The padding is deliberately placed in front of the
//   write, so that no shadow memory clear can fall between write and
//   read and the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The read line
//   through the rare alias is expected to be the first key to vanish
//   from the sampled dependency file, which leaves the same write
//   instruction paired with a smaller set of read instructions than in
//   the baseline.
// ==========================================================

static short g_cell;

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
    g_cell = 0;
    pad_writes(40);
    short* alias_a = &g_cell;
    short* alias_b = &g_cell;
    short* chosen = (rand() % 2 == 0) ? alias_a : alias_b;
    *chosen = 62;        // Sink
    const short* src_alias_main = &g_cell;
    const short* src_alias_rare = &g_cell;
    short observed = 0;
    if (tick % 19 == 5) {
        observed = *src_alias_rare;    // Source (rare alias)
    } else {
        observed = *src_alias_main;    // Source (frequent alias)
    }
    tick = tick + 1;
    (void) observed;
}
