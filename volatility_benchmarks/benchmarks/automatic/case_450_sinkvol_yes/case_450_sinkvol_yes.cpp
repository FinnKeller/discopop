// ==========================================================
// Case 450 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read through a const reference parameter
//   Sink   (write): VOLATILE - a switch over the tick counter with two rare arms and one default arm
// Idea:
//   The sink end offers more than one candidate write instruction: a
//   switch over the tick counter with two rare arms and one default
//   arm. The gate tick % 23 == 4 fires on about 4 of the 100
//   repetitions, so the two rare arm write lines gets very few chances
//   to fall inside a profiling window. The read end is a single
//   instruction - a read through a const reference parameter over a
//   plain stack scalar - so only the write end of the dependency can
//   change identity. Distance lever: 2560 padding reads, which shift
//   the window phase from repetition to repetition.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The two rare arm
//   write lines is expected to be the first edge to disappear from the
//   sampled dependency set, which leaves the same read instruction
//   paired with a smaller set of write instructions than in the
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

static char load_ref(const char& source) {
    return source;        // Source
}

int main() {
    static int tick = 0;
    char cell = 0;
    switch (tick % 23) {
    case 4:
        cell = 50;                   // Sink (rare arm)
        break;
    case 5:
        cell = 56;                   // Sink (second rare arm)
        break;
    default:
        cell = 43;                   // Sink (default arm)
        break;
    }
    int pad_noise = pad_reads(40);
    (void) pad_noise;
    char observed = load_ref(cell);
    tick = tick + 1;
    (void) observed;
}
