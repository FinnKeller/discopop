// ==========================================================
// Case 415 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read two call levels down
//   Sink   (write): VOLATILE - two lambdas, the second one invoked only rarely
// Idea:
//   The sink end offers more than one candidate write instruction: two
//   lambdas, the second one invoked only rarely. The gate tick % 23 ==
//   4 fires on about 4 of the 100 repetitions, so the write line
//   inside the rare lambda gets very few chances to fall inside a
//   profiling window. The read end is a single instruction - a read
//   two call levels down over a heap cell allocated and released per
//   repetition - so only the write end of the dependency can change
//   identity. Distance lever: 256 padding writes, enough to cross the
//   smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare lambda is expected to be the first edge to
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

static int load_inner(const int* source) {
    return *source;        // Source
}

static int load_outer(const int* source) {
    return load_inner(source);
}

int main() {
    static int tick = 0;
    int* cell = new int(0);
    auto store_common = [](int* target) { *target = 70; };   // Sink (frequent)
    auto store_rare = [](int* target) { *target = 77; };   // Sink (rare)
    if (tick % 23 == 4) {
        store_rare(cell);
    } else {
        store_common(cell);
    }
    pad_writes(8);
    int observed = load_outer(cell);
    tick = tick + 1;
    (void) observed;
    delete cell;
}
