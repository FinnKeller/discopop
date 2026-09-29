// ==========================================================
// Case 418 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read through a local pointer
//   Sink   (write): VOLATILE - two writer functions, the second one called only rarely
// Idea:
//   The sink end offers more than one candidate write instruction: two
//   writer functions, the second one called only rarely. The gate tick
//   % 19 == 5 fires on about 5 of the 100 repetitions, so the write
//   line inside the rare writer gets very few chances to fall inside a
//   profiling window. The read end is a single instruction - a read
//   through a local pointer over a translation unit global scalar - so
//   only the write end of the dependency can change identity. Distance
//   lever: 2560 padding reads, which shift the window phase from
//   repetition to repetition.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare writer is expected to be the first edge to
//   disappear from the sampled dependency set, which leaves the same
//   read instruction paired with a smaller set of write instructions
//   than in the baseline.
// ==========================================================

static unsigned int g_cell;

static void store_common(unsigned int* target) {
    *target = 43;                   // Sink (frequent)
}

static void store_rare(unsigned int* target) {
    *target = 50;                   // Sink (rare)
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
    g_cell = 0;
    if (tick % 19 == 5) {
        store_rare(&g_cell);
    } else {
        store_common(&g_cell);
    }
    int pad_noise = pad_reads(40);
    (void) pad_noise;
    const unsigned int* src_ptr = &g_cell;
    unsigned int observed = *src_ptr;        // Source
    tick = tick + 1;
    (void) observed;
}
