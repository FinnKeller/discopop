// ==========================================================
// Case 488 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a frequent read plus a rare extra read of the same cell
//   Sink   (write): stable   - an assignment through a local pointer
// Idea:
//   The source end offers more than one candidate read instruction: a
//   frequent read plus a rare extra read of the same cell. The gate
//   tick % 37 == 11 fires on about 2 of the 100 repetitions, so the
//   extra read line gets very few chances to fall inside a profiling
//   window. The write end is a single instruction - an assignment
//   through a local pointer over a plain stack scalar - so only the
//   read end of the dependency can change identity. Distance lever:
//   256 padding writes, enough to cross the smaller sampling windows.
//   The padding is deliberately placed in front of the write, so that
//   no shadow memory clear can fall between write and read and the
//   sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The extra read line
//   is expected to be the first key to vanish from the sampled
//   dependency file, which leaves the same write instruction paired
//   with a smaller set of read instructions than in the baseline.
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
    short cell = 0;
    pad_writes(8);
    short* sink_ptr = &cell;
    *sink_ptr = 25;        // Sink
    short observed = cell;              // Source (frequent)
    if (tick % 37 == 11) {
        observed += cell;            // Source (rare extra read)
    }
    tick = tick + 1;
    (void) observed;
}
