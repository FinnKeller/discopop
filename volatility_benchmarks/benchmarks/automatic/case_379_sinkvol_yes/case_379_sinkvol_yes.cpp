// ==========================================================
// Case 379 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read two call levels down
//   Sink   (write): VOLATILE - two aliases of the same cell, the second one used only rarely
// Idea:
//   The sink end offers more than one candidate write instruction: two
//   aliases of the same cell, the second one used only rarely. The
//   gate tick % 19 == 5 fires on about 5 of the 100 repetitions, so
//   the write line through the rare alias gets very few chances to
//   fall inside a profiling window. The read end is a single
//   instruction - a read two call levels down over a heap cell whose
//   address moves every repetition - so only the write end of the
//   dependency can change identity. Distance lever: 256 padding
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

static short load_inner(const short* source) {
    return *source;        // Source
}

static short load_outer(const short* source) {
    return load_inner(source);
}

int main() {
    static int tick = 0;
    short* cell = new short(0);
    short* sink_alias_main = cell;
    short* sink_alias_rare = cell;
    if (tick % 19 == 5) {
        *sink_alias_rare = 35;          // Sink (rare alias)
    } else {
        *sink_alias_main = 28;          // Sink (frequent alias)
    }
    pad_writes(8);
    short observed = load_outer(cell);
    tick = tick + 1;
    (void) observed;
}
