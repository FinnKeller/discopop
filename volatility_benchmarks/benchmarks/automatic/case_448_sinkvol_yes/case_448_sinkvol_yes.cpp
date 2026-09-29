// ==========================================================
// Case 448 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a plain read
//   Sink   (write): VOLATILE - a function pointer that is rarely retargeted to a second writer
// Idea:
//   The sink end offers more than one candidate write instruction: a
//   function pointer that is rarely retargeted to a second writer. The
//   gate tick % 37 == 11 fires on about 2 of the 100 repetitions, so
//   the write line inside the rare target gets very few chances to
//   fall inside a profiling window. The read end is a single
//   instruction - a plain read over the value member of a stack union
//   - so only the write end of the dependency can change identity.
//   Distance lever: 256 padding writes, enough to cross the smaller
//   sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare target is expected to be the first edge to
//   disappear from the sampled dependency set, which leaves the same
//   read instruction paired with a smaller set of write instructions
//   than in the baseline.
// ==========================================================

union Slot { short as_value; unsigned char raw[sizeof(short)]; };

static void store_common(short* target) {
    *target = 41;                   // Sink (frequent)
}

static void store_rare(short* target) {
    *target = 48;                   // Sink (rare)
}

static int pad_area[32];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 32; ++i) {
            pad_area[i] = r ^ i;
        }
    }
}

int main() {
    static int tick = 0;
    Slot slot;
    void (*sink_fp)(short*) = store_common;
    if (tick % 37 == 11) {
        sink_fp = store_rare;
    }
    sink_fp(&slot.as_value);
    pad_writes(8);
    short observed = slot.as_value;        // Source
    tick = tick + 1;
    (void) observed;
}
