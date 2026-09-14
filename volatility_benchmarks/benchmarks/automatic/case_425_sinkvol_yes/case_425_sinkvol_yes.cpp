// ==========================================================
// Case 425 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read through a local pointer
//   Sink   (write): VOLATILE - a frequent write plus a rare patch write
// Idea:
//   The sink end offers more than one candidate write instruction: a
//   frequent write plus a rare patch write. The gate tick % 37 == 29
//   fires on about 2 of the 100 repetitions, so the patch write line
//   gets very few chances to fall inside a profiling window. The read
//   end is a single instruction - a read through a local pointer over
//   a stack array element reached by pointer arithmetic - so only the
//   write end of the dependency can change identity. Distance lever:
//   256 padding writes, enough to cross the smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The patch write line
//   is expected to be the first edge to disappear from the sampled
//   dependency set, which leaves the same read instruction paired with
//   a smaller set of write instructions than in the baseline.
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
    unsigned int arr[16];
    unsigned int* cursor = arr + 5;
    *cursor = 51;                       // Sink (frequent)
    if (tick % 37 == 29) {
        *cursor = 58;                   // Sink (rare patch)
    }
    pad_writes(8);
    const unsigned int* src_ptr = cursor;
    unsigned int observed = *src_ptr;        // Source
    tick = tick + 1;
    (void) observed;
}
