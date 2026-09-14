#include <stdlib.h>

// ==========================================================
// Case 513 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a frequent read plus a rare extra read of the same cell
//   Sink   (write): stable   - an assignment reached through a randomly indexed table whose slots are all the same function
// Idea:
//   The source end offers more than one candidate read instruction: a
//   frequent read plus a rare extra read of the same cell. The gate
//   tick % 29 == 9 fires on about 3 of the 100 repetitions, so the
//   extra read line gets very few chances to fall inside a profiling
//   window. The write end is a single instruction - an assignment
//   reached through a randomly indexed table whose slots are all the
//   same function over a translation unit global scalar - so only the
//   read end of the dependency can change identity. Distance lever:
//   256 padding writes, enough to cross the smaller sampling windows.
//   The padding is deliberately placed in front of the write, so that
//   no shadow memory clear can fall between write and read and the
//   sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The extra read line
//   is expected to be the first key to vanish from the sampled
//   dependency file, which leaves the same write instruction paired
//   with a smaller set of read instructions than in the baseline.
// ==========================================================

static char g_cell;

static int pad_area[32];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 32; ++i) {
            pad_area[i] = r ^ i;
        }
    }
}

static void store_value(char* target) {
    *target = 53;        // Sink
}

int main() {
    static int tick = 0;
    g_cell = 0;
    pad_writes(8);
    void (*sink_table[4])(char*) = { store_value, store_value, store_value, store_value };
    sink_table[rand() % 4](&g_cell);
    char observed = g_cell;              // Source (frequent)
    if (tick % 29 == 9) {
        observed += g_cell;            // Source (rare extra read)
    }
    tick = tick + 1;
    (void) observed;
}
