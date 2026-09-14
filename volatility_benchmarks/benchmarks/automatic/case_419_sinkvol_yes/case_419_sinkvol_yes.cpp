// ==========================================================
// Case 419 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read two call levels down
//   Sink   (write): VOLATILE - two loop shapes carrying two different write instructions
// Idea:
//   The sink end offers more than one candidate write instruction: two
//   loop shapes carrying two different write instructions. The gate
//   tick % 29 == 9 fires on about 3 of the 100 repetitions, so the
//   write line of the rare loop shape gets very few chances to fall
//   inside a profiling window. The read end is a single instruction -
//   a read two call levels down over a heap cell whose address moves
//   every repetition - so only the write end of the dependency can
//   change identity. No distance lever is used; rarity alone carries
//   the case.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line of
//   the rare loop shape is expected to be the first edge to disappear
//   from the sampled dependency set, which leaves the same read
//   instruction paired with a smaller set of write instructions than
//   in the baseline.
// ==========================================================

static long long load_inner(const long long* source) {
    return *source;        // Source
}

static long long load_outer(const long long* source) {
    return load_inner(source);
}

int main() {
    static int tick = 0;
    long long* cell = new long long(0);
    if (tick % 29 == 9) {
        for (int i = 0; i < 16; i += 1) {
            if (i == 7) { *cell = 40; } // Sink (rare dense loop)
        }
    } else {
        for (int i = 0; i < 16; i += 7) {
            if (i == 7) { *cell = 33; } // Sink (frequent sparse loop)
        }
    }
    long long observed = load_outer(cell);
    tick = tick + 1;
    (void) observed;
}
