// ==========================================================
// Case 469 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - two read instructions in the arms of a rare/frequent branch
//   Sink   (write): stable   - an assignment inside a lambda
// Idea:
//   The source end offers more than one candidate read instruction:
//   two read instructions in the arms of a rare/frequent branch. The
//   gate tick % 19 == 5 fires on about 5 of the 100 repetitions, so
//   the rare arm read line gets very few chances to fall inside a
//   profiling window. The write end is a single instruction - an
//   assignment inside a lambda over a function local static scalar -
//   so only the read end of the dependency can change identity.
//   Distance lever: 256 padding writes, enough to cross the smaller
//   sampling windows. The padding is deliberately placed in front of
//   the write, so that no shadow memory clear can fall between write
//   and read and the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The rare arm read
//   line is expected to be the first key to vanish from the sampled
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
    static short cell;
    cell = 0;
    pad_writes(8);
    auto sink_lambda = [](short* target) { *target = 48; };        // Sink
    sink_lambda(&cell);
    short observed = 0;
    if (tick % 19 == 5) {
        observed = cell + 1;         // Source (rare arm)
    } else {
        observed = cell + 2;         // Source (frequent arm)
    }
    tick = tick + 1;
    (void) observed;
}
