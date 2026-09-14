// ==========================================================
// Case 410 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read inside a lambda
//   Sink   (write): VOLATILE - a switch over the tick counter with two rare arms and one default arm
// Idea:
//   The sink end offers more than one candidate write instruction: a
//   switch over the tick counter with two rare arms and one default
//   arm. The gate tick % 23 == 4 fires on about 4 of the 100
//   repetitions, so the two rare arm write lines gets very few chances
//   to fall inside a profiling window. The read end is a single
//   instruction - a read inside a lambda over a translation unit
//   global scalar - so only the write end of the dependency can change
//   identity. Distance lever: 256 padding writes, enough to cross the
//   smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The two rare arm
//   write lines is expected to be the first edge to disappear from the
//   sampled dependency set, which leaves the same read instruction
//   paired with a smaller set of write instructions than in the
//   baseline.
// ==========================================================

static char g_cell;

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
    g_cell = 0;
    switch (tick % 23) {
    case 4:
        g_cell = 64;                   // Sink (rare arm)
        break;
    case 5:
        g_cell = 70;                   // Sink (second rare arm)
        break;
    default:
        g_cell = 57;                   // Sink (default arm)
        break;
    }
    pad_writes(8);
    auto src_lambda = [](const char* source) { return *source; };        // Source
    char observed = src_lambda(&g_cell);
    tick = tick + 1;
    (void) observed;
}
