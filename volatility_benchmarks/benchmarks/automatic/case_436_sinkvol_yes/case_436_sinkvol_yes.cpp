// ==========================================================
// Case 436 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read inside a function template instance
//   Sink   (write): VOLATILE - two aliases of the same cell, the second one used only rarely
// Idea:
//   The sink end offers more than one candidate write instruction: two
//   aliases of the same cell, the second one used only rarely. The
//   gate tick % 41 == 13 fires on about 2 of the 100 repetitions, so
//   the write line through the rare alias gets very few chances to
//   fall inside a profiling window. The read end is a single
//   instruction - a read inside a function template instance over a
//   stack array element reached by pointer arithmetic - so only the
//   write end of the dependency can change identity. Distance lever:
//   256 padding reads, enough to cross the smaller sampling windows.
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

template <typename V>
static V load_generic(const V* source) {
    return *source;        // Source
}

int main() {
    static int tick = 0;
    long arr[16];
    long* cursor = arr + 5;
    long* sink_alias_main = cursor;
    long* sink_alias_rare = cursor;
    if (tick % 41 == 13) {
        *sink_alias_rare = 80;          // Sink (rare alias)
    } else {
        *sink_alias_main = 73;          // Sink (frequent alias)
    }
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    long observed = load_generic<long>(cursor);
    tick = tick + 1;
    (void) observed;
}
