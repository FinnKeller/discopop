// ==========================================================
// Case 518 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - two lambdas, the second one invoked only rarely
//   Sink   (write): stable   - an assignment two call levels down
// Idea:
//   The source end offers more than one candidate read instruction:
//   two lambdas, the second one invoked only rarely. The gate tick %
//   29 == 9 fires on about 3 of the 100 repetitions, so the read line
//   inside the rare lambda gets very few chances to fall inside a
//   profiling window. The write end is a single instruction - an
//   assignment two call levels down over a heap cell whose address
//   moves every repetition - so only the read end of the dependency
//   can change identity. Distance lever: 2560 padding reads, which
//   shift the window phase from repetition to repetition. The padding
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

static void store_inner(unsigned int* target) {
    *target = 77;        // Sink
}

static void store_outer(unsigned int* target) {
    store_inner(target);
}

int main() {
    static int tick = 0;
    unsigned int* cell = new unsigned int(0);
    int pad_noise = pad_reads(40);
    (void) pad_noise;
    store_outer(cell);
    auto load_common = [](const unsigned int* source) { return *source + 1; };  // Source (frequent)
    auto load_rare = [](const unsigned int* source) { return *source + 2; };    // Source (rare)
    unsigned int observed = 0;
    if (tick % 29 == 9) {
        observed = load_rare(cell);
    } else {
        observed = load_common(cell);
    }
    tick = tick + 1;
    (void) observed;
}
