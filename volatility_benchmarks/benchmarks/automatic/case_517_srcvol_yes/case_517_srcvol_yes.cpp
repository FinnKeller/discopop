// ==========================================================
// Case 517 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - two lambdas, the second one invoked only rarely
//   Sink   (write): stable   - an assignment reached through a function pointer with a single target
// Idea:
//   The source end offers more than one candidate read instruction:
//   two lambdas, the second one invoked only rarely. The gate tick %
//   31 == 17 fires on about 3 of the 100 repetitions, so the read line
//   inside the rare lambda gets very few chances to fall inside a
//   profiling window. The write end is a single instruction - an
//   assignment reached through a function pointer with a single target
//   over a translation unit global scalar - so only the read end of
//   the dependency can change identity. No distance lever is used;
//   rarity alone carries the case. The padding is deliberately placed
//   in front of the write, so that no shadow memory clear can fall
//   between write and read and the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The read line inside
//   the rare lambda is expected to be the first key to vanish from the
//   sampled dependency file, which leaves the same write instruction
//   paired with a smaller set of read instructions than in the
//   baseline.
// ==========================================================

static unsigned int g_cell;

static void store_value(unsigned int* target) {
    *target = 48;        // Sink
}

int main() {
    static int tick = 0;
    g_cell = 0;
    void (*sink_fp)(unsigned int*) = store_value;
    sink_fp(&g_cell);
    auto load_common = [](const unsigned int* source) { return *source + 1; };  // Source (frequent)
    auto load_rare = [](const unsigned int* source) { return *source + 2; };    // Source (rare)
    unsigned int observed = 0;
    if (tick % 31 == 17) {
        observed = load_rare(&g_cell);
    } else {
        observed = load_common(&g_cell);
    }
    tick = tick + 1;
    (void) observed;
}
