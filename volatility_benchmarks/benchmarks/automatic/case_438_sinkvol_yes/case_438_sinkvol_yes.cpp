// ==========================================================
// Case 438 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read inside a lambda
//   Sink   (write): VOLATILE - a function pointer that is rarely retargeted to a second writer
// Idea:
//   The sink end offers more than one candidate write instruction: a
//   function pointer that is rarely retargeted to a second writer. The
//   gate tick % 29 == 9 fires on about 3 of the 100 repetitions, so
//   the write line inside the rare target gets very few chances to
//   fall inside a profiling window. The read end is a single
//   instruction - a read inside a lambda over one element of a stack
//   array - so only the write end of the dependency can change
//   identity. Distance lever: 256 padding reads, enough to cross the
//   smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare target is expected to be the first edge to
//   disappear from the sampled dependency set, which leaves the same
//   read instruction paired with a smaller set of write instructions
//   than in the baseline.
// ==========================================================

static void store_common(long* target) {
    *target = 51;                   // Sink (frequent)
}

static void store_rare(long* target) {
    *target = 58;                   // Sink (rare)
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

int main() {
    static int tick = 0;
    long arr[16];
    void (*sink_fp)(long*) = store_common;
    if (tick % 29 == 9) {
        sink_fp = store_rare;
    }
    sink_fp(&arr[7]);
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    auto src_lambda = [](const long* source) { return *source; };        // Source
    long observed = src_lambda(&arr[7]);
    tick = tick + 1;
    (void) observed;
}
