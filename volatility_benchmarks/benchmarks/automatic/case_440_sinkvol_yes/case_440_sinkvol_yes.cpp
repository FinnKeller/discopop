// ==========================================================
// Case 440 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a plain read
//   Sink   (write): VOLATILE - a function pointer that is rarely retargeted to a second writer
// Idea:
//   The sink end offers more than one candidate write instruction: a
//   function pointer that is rarely retargeted to a second writer. The
//   gate tick % 23 == 4 fires on about 4 of the 100 repetitions, so
//   the write line inside the rare target gets very few chances to
//   fall inside a profiling window. The read end is a single
//   instruction - a plain read over the value member of a stack union
//   - so only the write end of the dependency can change identity.
//   Distance lever: 2560 padding reads, which shift the window phase
//   from repetition to repetition.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare target is expected to be the first edge to
//   disappear from the sampled dependency set, which leaves the same
//   read instruction paired with a smaller set of write instructions
//   than in the baseline.
// ==========================================================

union Slot { long as_value; unsigned char raw[sizeof(long)]; };

static void store_common(long* target) {
    *target = 40;                   // Sink (frequent)
}

static void store_rare(long* target) {
    *target = 47;                   // Sink (rare)
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

int main() {
    static int tick = 0;
    Slot slot;
    void (*sink_fp)(long*) = store_common;
    if (tick % 23 == 4) {
        sink_fp = store_rare;
    }
    sink_fp(&slot.as_value);
    int pad_noise = pad_reads(40);
    (void) pad_noise;
    long observed = slot.as_value;        // Source
    tick = tick + 1;
    (void) observed;
}
