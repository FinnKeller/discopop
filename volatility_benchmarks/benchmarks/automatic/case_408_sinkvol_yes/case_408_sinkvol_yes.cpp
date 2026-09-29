// ==========================================================
// Case 408 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read inside a function template instance
//   Sink   (write): VOLATILE - a function pointer that is rarely retargeted to a second writer
// Idea:
//   The sink end offers more than one candidate write instruction: a
//   function pointer that is rarely retargeted to a second writer. The
//   gate tick % 41 == 13 fires on about 2 of the 100 repetitions, so
//   the write line inside the rare target gets very few chances to
//   fall inside a profiling window. The read end is a single
//   instruction - a read inside a function template instance over a
//   field of a heap struct - so only the write end of the dependency
//   can change identity. Distance lever: 256 padding reads, enough to
//   cross the smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare target is expected to be the first edge to
//   disappear from the sampled dependency set, which leaves the same
//   read instruction paired with a smaller set of write instructions
//   than in the baseline.
// ==========================================================

struct Box { short guard; short payload; };

static void store_common(short* target) {
    *target = 27;                   // Sink (frequent)
}

static void store_rare(short* target) {
    *target = 34;                   // Sink (rare)
}

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
    Box* box = new Box;
    box->guard = 0;
    void (*sink_fp)(short*) = store_common;
    if (tick % 41 == 13) {
        sink_fp = store_rare;
    }
    sink_fp(&box->payload);
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    short observed = load_generic<short>(&box->payload);
    tick = tick + 1;
    (void) observed;
}
