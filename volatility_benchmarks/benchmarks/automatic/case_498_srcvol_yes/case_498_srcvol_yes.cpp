// ==========================================================
// Case 498 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a switch over the tick counter with two rare arms and one default arm
//   Sink   (write): stable   - an assignment inside a lambda
// Idea:
//   The source end offers more than one candidate read instruction: a
//   switch over the tick counter with two rare arms and one default
//   arm. The gate tick % 31 == 17 fires on about 3 of the 100
//   repetitions, so the two rare arm read lines gets very few chances
//   to fall inside a profiling window. The write end is a single
//   instruction - an assignment inside a lambda over a heap cell
//   allocated and released per repetition - so only the read end of
//   the dependency can change identity. Distance lever: 2560 padding
//   reads, which shift the window phase from repetition to repetition.
//   The padding is deliberately placed in front of the write, so that
//   no shadow memory clear can fall between write and read and the
//   sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The two rare arm
//   read lines is expected to be the first key to vanish from the
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

int main() {
    static int tick = 0;
    char* cell = new char(0);
    int pad_noise = pad_reads(40);
    (void) pad_noise;
    auto sink_lambda = [](char* target) { *target = 71; };        // Sink
    sink_lambda(cell);
    char observed = 0;
    switch (tick % 31) {
    case 17:
        observed = *cell + 1;         // Source (rare arm)
        break;
    case 18:
        observed = *cell + 2;         // Source (second rare arm)
        break;
    default:
        observed = *cell + 3;         // Source (default arm)
        break;
    }
    tick = tick + 1;
    (void) observed;
    delete cell;
}
