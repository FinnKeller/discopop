// ==========================================================
// Case 521 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a two slot function pointer table whose second slot is selected only rarely
//   Sink   (write): stable   - an assignment inside a writer function
// Idea:
//   The source end offers more than one candidate read instruction: a
//   two slot function pointer table whose second slot is selected only
//   rarely. The gate tick % 29 == 9 fires on about 3 of the 100
//   repetitions, so the read line of the rare slot gets very few
//   chances to fall inside a profiling window. The write end is a
//   single instruction - an assignment inside a writer function over
//   one element of a stack array - so only the read end of the
//   dependency can change identity. Distance lever: 256 padding reads,
//   enough to cross the smaller sampling windows. The padding is
//   deliberately placed in front of the write, so that no shadow
//   memory clear can fall between write and read and the sink end
//   stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The read line of the
//   rare slot is expected to be the first key to vanish from the
//   sampled dependency file, which leaves the same write instruction
//   paired with a smaller set of read instructions than in the
//   baseline.
// ==========================================================

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

static void store_value(long* target) {
    *target = 45;        // Sink
}

static long load_common(const long* source) {
    return *source + 1;             // Source (frequent)
}

static long load_rare(const long* source) {
    return *source + 2;             // Source (rare)
}

int main() {
    static int tick = 0;
    long arr[16];
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    store_value(&arr[7]);
    long (*src_table[2])(const long*) = { load_common, load_rare };
    int src_slot = (tick % 29 == 9) ? 1 : 0;
    long observed = src_table[src_slot](&arr[7]);
    tick = tick + 1;
    (void) observed;
}
