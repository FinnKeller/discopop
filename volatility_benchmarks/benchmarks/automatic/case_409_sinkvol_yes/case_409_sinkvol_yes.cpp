// ==========================================================
// Case 409 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a plain read
//   Sink   (write): VOLATILE - a frequent write plus a rare patch write
// Idea:
//   The sink end offers more than one candidate write instruction: a
//   frequent write plus a rare patch write. The gate tick % 31 == 7
//   fires on about 3 of the 100 repetitions, so the patch write line
//   gets very few chances to fall inside a profiling window. The read
//   end is a single instruction - a plain read over a stack array
//   element reached by pointer arithmetic - so only the write end of
//   the dependency can change identity. Distance lever: 256 padding
//   reads, enough to cross the smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The patch write line
//   is expected to be the first edge to disappear from the sampled
//   dependency set, which leaves the same read instruction paired with
//   a smaller set of write instructions than in the baseline.
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

int main() {
    static int tick = 0;
    long arr[16];
    long* cursor = arr + 5;
    *cursor = 49;                       // Sink (frequent)
    if (tick % 31 == 7) {
        *cursor = 56;                   // Sink (rare patch)
    }
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    long observed = *cursor;        // Source
    tick = tick + 1;
    (void) observed;
}
