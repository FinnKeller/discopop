// ==========================================================
// Case 500 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a switch over the tick counter with two rare arms and one default arm
//   Sink   (write): stable   - a plain assignment
// Idea:
//   The source end offers more than one candidate read instruction: a
//   switch over the tick counter with two rare arms and one default
//   arm. The gate tick % 37 == 11 fires on about 2 of the 100
//   repetitions, so the two rare arm read lines gets very few chances
//   to fall inside a profiling window. The write end is a single
//   instruction - a plain assignment over a translation unit global
//   scalar - so only the read end of the dependency can change
//   identity. Distance lever: 256 padding reads, enough to cross the
//   smaller sampling windows. The padding is deliberately placed in
//   front of the write, so that no shadow memory clear can fall
//   between write and read and the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The two rare arm
//   read lines is expected to be the first key to vanish from the
//   sampled dependency file, which leaves the same write instruction
//   paired with a smaller set of read instructions than in the
//   baseline.
// ==========================================================

static char g_cell;

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

int main() {
    static int tick = 0;
    g_cell = 0;
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    g_cell = 35;        // Sink
    char observed = 0;
    switch (tick % 37) {
    case 11:
        observed = g_cell + 1;         // Source (rare arm)
        break;
    case 12:
        observed = g_cell + 2;         // Source (second rare arm)
        break;
    default:
        observed = g_cell + 3;         // Source (default arm)
        break;
    }
    tick = tick + 1;
    (void) observed;
}
