// ==========================================================
// Case 398 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a plain read
//   Sink   (write): VOLATILE - two lambdas, the second one invoked only rarely
// Idea:
//   The sink end offers more than one candidate write instruction: two
//   lambdas, the second one invoked only rarely. The gate tick % 19 ==
//   12 fires on about 5 of the 100 repetitions, so the write line
//   inside the rare lambda gets very few chances to fall inside a
//   profiling window. The read end is a single instruction - a plain
//   read over a plain stack scalar - so only the write end of the
//   dependency can change identity. Distance lever: 256 padding
//   writes, enough to cross the smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare lambda is expected to be the first edge to
//   disappear from the sampled dependency set, which leaves the same
//   read instruction paired with a smaller set of write instructions
//   than in the baseline.
// ==========================================================

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
    char cell = 0;
    auto store_common = [](char* target) { *target = 40; };   // Sink (frequent)
    auto store_rare = [](char* target) { *target = 47; };   // Sink (rare)
    if (tick % 19 == 12) {
        store_rare(&cell);
    } else {
        store_common(&cell);
    }
    pad_writes(8);
    char observed = cell;        // Source
    tick = tick + 1;
    (void) observed;
}
