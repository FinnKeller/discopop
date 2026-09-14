#include <stdlib.h>

// ==========================================================
// Case 487 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a recursive reader that rarely stops one level early, at a different read line
//   Sink   (write): stable   - an assignment through one of two pointers that denote the same object
// Idea:
//   The source end offers more than one candidate read instruction: a
//   recursive reader that rarely stops one level early, at a different
//   read line. The gate tick % 29 == 9 fires on about 3 of the 100
//   repetitions, so the shallow stop read line gets very few chances
//   to fall inside a profiling window. The write end is a single
//   instruction - an assignment through one of two pointers that
//   denote the same object over a translation unit global scalar - so
//   only the read end of the dependency can change identity. Distance
//   lever: 2560 padding writes, which guarantee a shadow memory clear
//   for every batch size. The padding is deliberately placed in front
//   of the write, so that no shadow memory clear can fall between
//   write and read and the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The shallow stop
//   read line is expected to be the first key to vanish from the
//   sampled dependency file, which leaves the same write instruction
//   paired with a smaller set of read instructions than in the
//   baseline.
// ==========================================================

static char g_cell;

static int pad_area[64];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
            pad_area[i] = r ^ i;
        }
    }
}

static char load_descend(const char* source, int depth, int shallow) {
    if (shallow != 0 && depth == 1) {
        return *source + 2;         // Source (rare shallow stop)
    }
    if (depth == 0) {
        return *source + 1;         // Source (bottom of recursion)
    }
    return load_descend(source, depth - 1, shallow);
}

int main() {
    static int tick = 0;
    g_cell = 0;
    pad_writes(40);
    char* alias_a = &g_cell;
    char* alias_b = &g_cell;
    char* chosen = (rand() % 2 == 0) ? alias_a : alias_b;
    *chosen = 65;        // Sink
    int src_shallow = (tick % 29 == 9) ? 1 : 0;
    char observed = load_descend(&g_cell, 3, src_shallow);
    tick = tick + 1;
    (void) observed;
}
