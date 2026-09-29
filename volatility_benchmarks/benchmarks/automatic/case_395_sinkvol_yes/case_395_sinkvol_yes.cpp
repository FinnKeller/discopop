// ==========================================================
// Case 395 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a plain read
//   Sink   (write): VOLATILE - two writer functions, the second one called only rarely
// Idea:
//   The sink end offers more than one candidate write instruction: two
//   writer functions, the second one called only rarely. The gate tick
//   % 37 == 29 fires on about 2 of the 100 repetitions, so the write
//   line inside the rare writer gets very few chances to fall inside a
//   profiling window. The read end is a single instruction - a plain
//   read over a heap cell whose address moves every repetition - so
//   only the write end of the dependency can change identity. Distance
//   lever: 256 padding writes, enough to cross the smaller sampling
//   windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare writer is expected to be the first edge to
//   disappear from the sampled dependency set, which leaves the same
//   read instruction paired with a smaller set of write instructions
//   than in the baseline.
// ==========================================================

static void store_common(int* target) {
    *target = 68;                   // Sink (frequent)
}

static void store_rare(int* target) {
    *target = 75;                   // Sink (rare)
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
    int* cell = new int(0);
    if (tick % 37 == 29) {
        store_rare(cell);
    } else {
        store_common(cell);
    }
    pad_writes(8);
    int observed = *cell;        // Source
    tick = tick + 1;
    (void) observed;
}
