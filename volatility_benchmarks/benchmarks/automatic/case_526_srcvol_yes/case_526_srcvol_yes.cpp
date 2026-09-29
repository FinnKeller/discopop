// ==========================================================
// Case 526 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - two lambdas, the second one invoked only rarely
//   Sink   (write): stable   - an assignment through a reference parameter
// Idea:
//   The source end offers more than one candidate read instruction:
//   two lambdas, the second one invoked only rarely. The gate tick %
//   31 == 7 fires on about 3 of the 100 repetitions, so the read line
//   inside the rare lambda gets very few chances to fall inside a
//   profiling window. The write end is a single instruction - an
//   assignment through a reference parameter over a heap cell whose
//   address moves every repetition - so only the read end of the
//   dependency can change identity. Distance lever: 256 padding
//   writes, enough to cross the smaller sampling windows. The padding
//   is deliberately placed in front of the write, so that no shadow
//   memory clear can fall between write and read and the sink end
//   stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The read line inside
//   the rare lambda is expected to be the first key to vanish from the
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

static void store_ref(long long& target) {
    target = 66;        // Sink
}

int main() {
    static int tick = 0;
    long long* cell = new long long(0);
    pad_writes(8);
    store_ref(*cell);
    auto load_common = [](const long long* source) { return *source + 1; };  // Source (frequent)
    auto load_rare = [](const long long* source) { return *source + 2; };    // Source (rare)
    long long observed = 0;
    if (tick % 31 == 7) {
        observed = load_rare(cell);
    } else {
        observed = load_common(cell);
    }
    tick = tick + 1;
    (void) observed;
}
