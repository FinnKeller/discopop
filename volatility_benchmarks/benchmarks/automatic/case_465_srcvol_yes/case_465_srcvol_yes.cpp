// ==========================================================
// Case 465 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a two slot function pointer table whose second slot is selected only rarely
//   Sink   (write): stable   - an assignment reached through a function pointer with a single target
// Idea:
//   The source end offers more than one candidate read instruction: a
//   two slot function pointer table whose second slot is selected only
//   rarely. The gate tick % 19 == 12 fires on about 5 of the 100
//   repetitions, so the read line of the rare slot gets very few
//   chances to fall inside a profiling window. The write end is a
//   single instruction - an assignment reached through a function
//   pointer with a single target over a function local static scalar -
//   so only the read end of the dependency can change identity.
//   Distance lever: 256 padding writes, enough to cross the smaller
//   sampling windows. The padding is deliberately placed in front of
//   the write, so that no shadow memory clear can fall between write
//   and read and the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The read line of the
//   rare slot is expected to be the first key to vanish from the
//   sampled dependency file, which leaves the same write instruction
//   paired with a smaller set of read instructions than in the
//   baseline.
// ==========================================================

static int pad_area[32];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 32; ++i) {
            pad_area[i] = r ^ i;
        }
    }
}

static void store_value(int* target) {
    *target = 40;        // Sink
}

static int load_common(const int* source) {
    return *source + 1;             // Source (frequent)
}

static int load_rare(const int* source) {
    return *source + 2;             // Source (rare)
}

int main() {
    static int tick = 0;
    static int cell;
    cell = 0;
    pad_writes(8);
    void (*sink_fp)(int*) = store_value;
    sink_fp(&cell);
    int (*src_table[2])(const int*) = { load_common, load_rare };
    int src_slot = (tick % 19 == 12) ? 1 : 0;
    int observed = src_table[src_slot](&cell);
    tick = tick + 1;
    (void) observed;
}
