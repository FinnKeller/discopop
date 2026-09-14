// ==========================================================
// Case 491 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - two read instructions in the arms of a rare/frequent branch
//   Sink   (write): stable   - an assignment through a reference parameter
// Idea:
//   The source end offers more than one candidate read instruction:
//   two read instructions in the arms of a rare/frequent branch. The
//   gate tick % 41 == 23 fires on about 2 of the 100 repetitions, so
//   the rare arm read line gets very few chances to fall inside a
//   profiling window. The write end is a single instruction - an
//   assignment through a reference parameter over the value member of
//   a stack union - so only the read end of the dependency can change
//   identity. Distance lever: 2560 padding writes, which guarantee a
//   shadow memory clear for every batch size. The padding is
//   deliberately placed in front of the write, so that no shadow
//   memory clear can fall between write and read and the sink end
//   stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The rare arm read
//   line is expected to be the first key to vanish from the sampled
//   dependency file, which leaves the same write instruction paired
//   with a smaller set of read instructions than in the baseline.
// ==========================================================

union Slot { int as_value; unsigned char raw[sizeof(int)]; };

static int pad_area[64];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
            pad_area[i] = r ^ i;
        }
    }
}

static void store_ref(int& target) {
    target = 22;        // Sink
}

int main() {
    static int tick = 0;
    Slot slot;
    pad_writes(40);
    store_ref(slot.as_value);
    int observed = 0;
    if (tick % 41 == 23) {
        observed = slot.as_value + 1;         // Source (rare arm)
    } else {
        observed = slot.as_value + 2;         // Source (frequent arm)
    }
    tick = tick + 1;
    (void) observed;
}
