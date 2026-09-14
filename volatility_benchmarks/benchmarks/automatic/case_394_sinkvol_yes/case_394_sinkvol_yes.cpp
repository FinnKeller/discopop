// ==========================================================
// Case 394 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read two call levels down
//   Sink   (write): VOLATILE - a switch over the tick counter with two rare arms and one default arm
// Idea:
//   The sink end offers more than one candidate write instruction: a
//   switch over the tick counter with two rare arms and one default
//   arm. The gate tick % 31 == 7 fires on about 3 of the 100
//   repetitions, so the two rare arm write lines gets very few chances
//   to fall inside a profiling window. The read end is a single
//   instruction - a read two call levels down over a function local
//   static scalar - so only the write end of the dependency can change
//   identity. Distance lever: 256 padding reads, enough to cross the
//   smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The two rare arm
//   write lines is expected to be the first edge to disappear from the
//   sampled dependency set, which leaves the same read instruction
//   paired with a smaller set of write instructions than in the
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

static unsigned int load_inner(const unsigned int* source) {
    return *source;        // Source
}

static unsigned int load_outer(const unsigned int* source) {
    return load_inner(source);
}

int main() {
    static int tick = 0;
    static unsigned int cell;
    cell = 0;
    switch (tick % 31) {
    case 7:
        cell = 55;                   // Sink (rare arm)
        break;
    case 8:
        cell = 61;                   // Sink (second rare arm)
        break;
    default:
        cell = 48;                   // Sink (default arm)
        break;
    }
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    unsigned int observed = load_outer(&cell);
    tick = tick + 1;
    (void) observed;
}
