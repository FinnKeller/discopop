// ==========================================================
// Case 446 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read through a const reference parameter
//   Sink   (write): VOLATILE - a function pointer that is rarely retargeted to a second writer
// Idea:
//   The sink end offers more than one candidate write instruction: a
//   function pointer that is rarely retargeted to a second writer. The
//   gate tick % 19 == 5 fires on about 5 of the 100 repetitions, so
//   the write line inside the rare target gets very few chances to
//   fall inside a profiling window. The read end is a single
//   instruction - a read through a const reference parameter over a
//   translation unit global scalar - so only the write end of the
//   dependency can change identity. Distance lever: 256 padding
//   writes, enough to cross the smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare target is expected to be the first edge to
//   disappear from the sampled dependency set, which leaves the same
//   read instruction paired with a smaller set of write instructions
//   than in the baseline.
// ==========================================================

static unsigned int g_cell;

static void store_common(unsigned int* target) {
    *target = 46;                   // Sink (frequent)
}

static void store_rare(unsigned int* target) {
    *target = 53;                   // Sink (rare)
}

static int pad_area[32];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 32; ++i) {
            pad_area[i] = r ^ i;
        }
    }
}

static unsigned int load_ref(const unsigned int& source) {
    return source;        // Source
}

int main() {
    static int tick = 0;
    g_cell = 0;
    void (*sink_fp)(unsigned int*) = store_common;
    if (tick % 19 == 5) {
        sink_fp = store_rare;
    }
    sink_fp(&g_cell);
    pad_writes(8);
    unsigned int observed = load_ref(g_cell);
    tick = tick + 1;
    (void) observed;
}
