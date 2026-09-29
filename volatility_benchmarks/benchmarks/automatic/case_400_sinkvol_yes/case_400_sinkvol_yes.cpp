// ==========================================================
// Case 400 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a plain read
//   Sink   (write): VOLATILE - two writer functions, the second one called only rarely
// Idea:
//   The sink end offers more than one candidate write instruction: two
//   writer functions, the second one called only rarely. The gate tick
//   % 31 == 17 fires on about 3 of the 100 repetitions, so the write
//   line inside the rare writer gets very few chances to fall inside a
//   profiling window. The read end is a single instruction - a plain
//   read over the value member of a stack union - so only the write
//   end of the dependency can change identity. Distance lever: 256
//   padding reads, enough to cross the smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare writer is expected to be the first edge to
//   disappear from the sampled dependency set, which leaves the same
//   read instruction paired with a smaller set of write instructions
//   than in the baseline.
// ==========================================================

union Slot { int as_value; unsigned char raw[sizeof(int)]; };

static void store_common(int* target) {
    *target = 36;                   // Sink (frequent)
}

static void store_rare(int* target) {
    *target = 43;                   // Sink (rare)
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
    Slot slot;
    if (tick % 31 == 17) {
        store_rare(&slot.as_value);
    } else {
        store_common(&slot.as_value);
    }
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    int observed = slot.as_value;        // Source
    tick = tick + 1;
    (void) observed;
}
