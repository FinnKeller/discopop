// ==========================================================
// Case 439 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a plain read
//   Sink   (write): VOLATILE - two aliases of the same cell, the second one used only rarely
// Idea:
//   The sink end offers more than one candidate write instruction: two
//   aliases of the same cell, the second one used only rarely. The
//   gate tick % 37 == 11 fires on about 2 of the 100 repetitions, so
//   the write line through the rare alias gets very few chances to
//   fall inside a profiling window. The read end is a single
//   instruction - a plain read over a heap cell allocated and released
//   per repetition - so only the write end of the dependency can
//   change identity. Distance lever: 256 padding reads, enough to
//   cross the smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   through the rare alias is expected to be the first edge to
//   disappear from the sampled dependency set, which leaves the same
//   read instruction paired with a smaller set of write instructions
//   than in the baseline.
// ==========================================================

static int pad_area[32];

static int pad_reads(int rounds) {
    int sum = 0;
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 32; ++i) {
            sum += pad_area[i];
        }
    }
    return sum;
}

int main() {
    static int tick = 0;
    int* cell = new int(0);
    int* sink_alias_main = cell;
    int* sink_alias_rare = cell;
    if (tick % 37 == 11) {
        *sink_alias_rare = 86;          // Sink (rare alias)
    } else {
        *sink_alias_main = 79;          // Sink (frequent alias)
    }
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    int observed = *cell;        // Source
    tick = tick + 1;
    (void) observed;
    delete cell;
}
