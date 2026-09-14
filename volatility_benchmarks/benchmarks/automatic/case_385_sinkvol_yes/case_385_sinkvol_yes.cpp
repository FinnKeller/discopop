// ==========================================================
// Case 385 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read through a local pointer
//   Sink   (write): VOLATILE - a switch over the tick counter with two rare arms and one default arm
// Idea:
//   The sink end offers more than one candidate write instruction: a
//   switch over the tick counter with two rare arms and one default
//   arm. The gate tick % 29 == 9 fires on about 3 of the 100
//   repetitions, so the two rare arm write lines gets very few chances
//   to fall inside a profiling window. The read end is a single
//   instruction - a read through a local pointer over a function local
//   static scalar - so only the write end of the dependency can change
//   identity. Distance lever: 256 padding writes, enough to cross the
//   smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The two rare arm
//   write lines is expected to be the first edge to disappear from the
//   sampled dependency set, which leaves the same read instruction
//   paired with a smaller set of write instructions than in the
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

int main() {
    static int tick = 0;
    static char cell;
    cell = 0;
    switch (tick % 29) {
    case 9:
        cell = 57;                   // Sink (rare arm)
        break;
    case 10:
        cell = 63;                   // Sink (second rare arm)
        break;
    default:
        cell = 50;                   // Sink (default arm)
        break;
    }
    pad_writes(8);
    const char* src_ptr = &cell;
    char observed = *src_ptr;        // Source
    tick = tick + 1;
    (void) observed;
}
