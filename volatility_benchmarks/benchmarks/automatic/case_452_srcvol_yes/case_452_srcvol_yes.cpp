// ==========================================================
// Case 452 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a frequent read plus a rare extra read of the same cell
//   Sink   (write): stable   - an assignment through a local pointer
// Idea:
//   The source end offers more than one candidate read instruction: a
//   frequent read plus a rare extra read of the same cell. The gate
//   tick % 23 == 4 fires on about 4 of the 100 repetitions, so the
//   extra read line gets very few chances to fall inside a profiling
//   window. The write end is a single instruction - an assignment
//   through a local pointer over one element of a stack array - so
//   only the read end of the dependency can change identity. No
//   distance lever is used; rarity alone carries the case. The padding
//   is deliberately placed in front of the write, so that no shadow
//   memory clear can fall between write and read and the sink end
//   stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The extra read line
//   is expected to be the first key to vanish from the sampled
//   dependency file, which leaves the same write instruction paired
//   with a smaller set of read instructions than in the baseline.
// ==========================================================

int main() {
    static int tick = 0;
    short arr[16];
    short* sink_ptr = &arr[7];
    *sink_ptr = 40;        // Sink
    short observed = arr[7];              // Source (frequent)
    if (tick % 23 == 4) {
        observed += arr[7];            // Source (rare extra read)
    }
    tick = tick + 1;
    (void) observed;
}
