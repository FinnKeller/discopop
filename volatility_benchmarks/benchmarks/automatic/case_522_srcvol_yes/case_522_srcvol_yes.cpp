// ==========================================================
// Case 522 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a function pointer that is rarely retargeted to a second reader
//   Sink   (write): stable   - an assignment inside a lambda
// Idea:
//   The source end offers more than one candidate read instruction: a
//   function pointer that is rarely retargeted to a second reader. The
//   gate tick % 37 == 29 fires on about 2 of the 100 repetitions, so
//   the read line inside the rare target gets very few chances to fall
//   inside a profiling window. The write end is a single instruction -
//   an assignment inside a lambda over a heap cell whose address moves
//   every repetition - so only the read end of the dependency can
//   change identity. Distance lever: 2560 padding writes, which
//   guarantee a shadow memory clear for every batch size. The padding
//   is deliberately placed in front of the write, so that no shadow
//   memory clear can fall between write and read and the sink end
//   stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The read line inside
//   the rare target is expected to be the first key to vanish from the
//   sampled dependency file, which leaves the same write instruction
//   paired with a smaller set of read instructions than in the
//   baseline.
// ==========================================================

static int pad_area[64];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
            pad_area[i] = r ^ i;
        }
    }
}

static unsigned int load_common(const unsigned int* source) {
    return *source + 1;             // Source (frequent)
}

static unsigned int load_rare(const unsigned int* source) {
    return *source + 2;             // Source (rare)
}

int main() {
    static int tick = 0;
    unsigned int* cell = new unsigned int(0);
    pad_writes(40);
    auto sink_lambda = [](unsigned int* target) { *target = 74; };        // Sink
    sink_lambda(cell);
    unsigned int (*src_fp)(const unsigned int*) = load_common;
    if (tick % 37 == 29) {
        src_fp = load_rare;
    }
    unsigned int observed = src_fp(cell);
    tick = tick + 1;
    (void) observed;
}
