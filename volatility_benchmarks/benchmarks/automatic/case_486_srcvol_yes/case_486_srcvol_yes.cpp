// ==========================================================
// Case 486 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - two reader functions, the second one called only rarely
//   Sink   (write): stable   - an assignment inside a lambda
// Idea:
//   The source end offers more than one candidate read instruction:
//   two reader functions, the second one called only rarely. The gate
//   tick % 19 == 12 fires on about 5 of the 100 repetitions, so the
//   read line inside the rare reader gets very few chances to fall
//   inside a profiling window. The write end is a single instruction -
//   an assignment inside a lambda over a heap cell whose address moves
//   every repetition - so only the read end of the dependency can
//   change identity. Distance lever: 2560 padding reads, which shift
//   the window phase from repetition to repetition. The padding is
//   deliberately placed in front of the write, so that no shadow
//   memory clear can fall between write and read and the sink end
//   stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The read line inside
//   the rare reader is expected to be the first key to vanish from the
//   sampled dependency file, which leaves the same write instruction
//   paired with a smaller set of read instructions than in the
//   baseline.
// ==========================================================

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

static long long load_common(const long long* source) {
    return *source + 1;             // Source (frequent)
}

static long long load_rare(const long long* source) {
    return *source + 2;             // Source (rare)
}

int main() {
    static int tick = 0;
    long long* cell = new long long(0);
    int pad_noise = pad_reads(40);
    (void) pad_noise;
    auto sink_lambda = [](long long* target) { *target = 75; };        // Sink
    sink_lambda(cell);
    long long observed = 0;
    if (tick % 19 == 12) {
        observed = load_rare(cell);
    } else {
        observed = load_common(cell);
    }
    tick = tick + 1;
    (void) observed;
}
