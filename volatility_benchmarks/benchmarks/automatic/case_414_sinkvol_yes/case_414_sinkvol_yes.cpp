// ==========================================================
// Case 414 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read inside a reader function
//   Sink   (write): VOLATILE - a function pointer that is rarely retargeted to a second writer
// Idea:
//   The sink end offers more than one candidate write instruction: a
//   function pointer that is rarely retargeted to a second writer. The
//   gate tick % 37 == 29 fires on about 2 of the 100 repetitions, so
//   the write line inside the rare target gets very few chances to
//   fall inside a profiling window. The read end is a single
//   instruction - a read inside a reader function over a plain stack
//   scalar - so only the write end of the dependency can change
//   identity. Distance lever: 2560 padding reads, which shift the
//   window phase from repetition to repetition.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare target is expected to be the first edge to
//   disappear from the sampled dependency set, which leaves the same
//   read instruction paired with a smaller set of write instructions
//   than in the baseline.
// ==========================================================

static void store_common(int* target) {
    *target = 29;                   // Sink (frequent)
}

static void store_rare(int* target) {
    *target = 36;                   // Sink (rare)
}

static int pad_area[64];

static int pad_reads(int rounds) {
    int sum = 0;
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
            sum += pad_area[i];
        }
    }
    return sum;
}

static int load_value(const int* source) {
    return *source;        // Source
}

int main() {
    static int tick = 0;
    int cell = 0;
    void (*sink_fp)(int*) = store_common;
    if (tick % 37 == 29) {
        sink_fp = store_rare;
    }
    sink_fp(&cell);
    int pad_noise = pad_reads(40);
    (void) pad_noise;
    int observed = load_value(&cell);
    tick = tick + 1;
    (void) observed;
}
