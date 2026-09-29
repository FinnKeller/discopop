#include <stdlib.h>

// ==========================================================
// Case 463 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a function pointer that is rarely retargeted to a second reader
//   Sink   (write): stable   - an assignment through one of two pointers that denote the same object
// Idea:
//   The source end offers more than one candidate read instruction: a
//   function pointer that is rarely retargeted to a second reader. The
//   gate tick % 29 == 19 fires on about 3 of the 100 repetitions, so
//   the read line inside the rare target gets very few chances to fall
//   inside a profiling window. The write end is a single instruction -
//   an assignment through one of two pointers that denote the same
//   object over a translation unit global scalar - so only the read
//   end of the dependency can change identity. No distance lever is
//   used; rarity alone carries the case. The padding is deliberately
//   placed in front of the write, so that no shadow memory clear can
//   fall between write and read and the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The read line inside
//   the rare target is expected to be the first key to vanish from the
//   sampled dependency file, which leaves the same write instruction
//   paired with a smaller set of read instructions than in the
//   baseline.
// ==========================================================

static long long g_cell;

static long long load_common(const long long* source) {
    return *source + 1;             // Source (frequent)
}

static long long load_rare(const long long* source) {
    return *source + 2;             // Source (rare)
}

int main() {
    static int tick = 0;
    g_cell = 0;
    long long* alias_a = &g_cell;
    long long* alias_b = &g_cell;
    long long* chosen = (rand() % 2 == 0) ? alias_a : alias_b;
    *chosen = 64;        // Sink
    long long (*src_fp)(const long long*) = load_common;
    if (tick % 29 == 19) {
        src_fp = load_rare;
    }
    long long observed = src_fp(&g_cell);
    tick = tick + 1;
    (void) observed;
}
