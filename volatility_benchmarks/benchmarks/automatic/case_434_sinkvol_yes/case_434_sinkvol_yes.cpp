// ==========================================================
// Case 434 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read inside a reader function
//   Sink   (write): VOLATILE - a function pointer that is rarely retargeted to a second writer
// Idea:
//   The sink end offers more than one candidate write instruction: a
//   function pointer that is rarely retargeted to a second writer. The
//   gate tick % 23 == 11 fires on about 4 of the 100 repetitions, so
//   the write line inside the rare target gets very few chances to
//   fall inside a profiling window. The read end is a single
//   instruction - a read inside a reader function over a function
//   local static scalar - so only the write end of the dependency can
//   change identity. Distance lever: 2560 padding writes, which
//   guarantee a shadow memory clear for every batch size.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare target is expected to be the first edge to
//   disappear from the sampled dependency set, which leaves the same
//   read instruction paired with a smaller set of write instructions
//   than in the baseline.
// ==========================================================

static void store_common(char* target) {
    *target = 41;                   // Sink (frequent)
}

static void store_rare(char* target) {
    *target = 48;                   // Sink (rare)
}

static int pad_area[64];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
            pad_area[i] = r ^ i;
        }
    }
}

static char load_value(const char* source) {
    return *source;        // Source
}

int main() {
    static int tick = 0;
    static char cell;
    cell = 0;
    void (*sink_fp)(char*) = store_common;
    if (tick % 23 == 11) {
        sink_fp = store_rare;
    }
    sink_fp(&cell);
    pad_writes(40);
    char observed = load_value(&cell);
    tick = tick + 1;
    (void) observed;
}
