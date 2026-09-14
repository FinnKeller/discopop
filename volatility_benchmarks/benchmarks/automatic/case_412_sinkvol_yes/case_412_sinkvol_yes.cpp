// ==========================================================
// Case 412 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read inside a function template instance
//   Sink   (write): VOLATILE - two aliases of the same cell, the second one used only rarely
// Idea:
//   The sink end offers more than one candidate write instruction: two
//   aliases of the same cell, the second one used only rarely. The
//   gate tick % 23 == 4 fires on about 4 of the 100 repetitions, so
//   the write line through the rare alias gets very few chances to
//   fall inside a profiling window. The read end is a single
//   instruction - a read inside a function template instance over a
//   plain stack scalar - so only the write end of the dependency can
//   change identity. Distance lever: 2560 padding writes, which
//   guarantee a shadow memory clear for every batch size.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   through the rare alias is expected to be the first edge to
//   disappear from the sampled dependency set, which leaves the same
//   read instruction paired with a smaller set of write instructions
//   than in the baseline.
// ==========================================================

static int pad_area[64];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
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
    short cell = 0;
    short* sink_alias_main = &cell;
    short* sink_alias_rare = &cell;
    if (tick % 23 == 4) {
        *sink_alias_rare = 53;          // Sink (rare alias)
    } else {
        *sink_alias_main = 46;          // Sink (frequent alias)
    }
    pad_writes(40);
    short observed = load_generic<short>(&cell);
    tick = tick + 1;
    (void) observed;
}
