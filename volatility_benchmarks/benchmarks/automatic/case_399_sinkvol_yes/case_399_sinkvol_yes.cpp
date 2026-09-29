// ==========================================================
// Case 399 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read through a const reference parameter
//   Sink   (write): VOLATILE - a frequent write plus a rare patch write
// Idea:
//   The sink end offers more than one candidate write instruction: a
//   frequent write plus a rare patch write. The gate tick % 31 == 17
//   fires on about 3 of the 100 repetitions, so the patch write line
//   gets very few chances to fall inside a profiling window. The read
//   end is a single instruction - a read through a const reference
//   parameter over a heap cell allocated and released per repetition -
//   so only the write end of the dependency can change identity.
//   Distance lever: 2560 padding writes, which guarantee a shadow
//   memory clear for every batch size.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The patch write line
//   is expected to be the first edge to disappear from the sampled
//   dependency set, which leaves the same read instruction paired with
//   a smaller set of write instructions than in the baseline.
// ==========================================================

static int pad_area[64];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
            pad_area[i] = r ^ i;
        }
    }
}

static char load_ref(const char& source) {
    return source;        // Source
}

int main() {
    static int tick = 0;
    char* cell = new char(0);
    *cell = 60;                       // Sink (frequent)
    if (tick % 31 == 17) {
        *cell = 67;                   // Sink (rare patch)
    }
    pad_writes(40);
    char observed = load_ref(*cell);
    tick = tick + 1;
    (void) observed;
    delete cell;
}
