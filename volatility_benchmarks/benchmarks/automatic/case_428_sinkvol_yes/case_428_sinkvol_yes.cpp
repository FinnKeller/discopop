// ==========================================================
// Case 428 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read inside a lambda
//   Sink   (write): VOLATILE - a frequent write plus a rare patch write
// Idea:
//   The sink end offers more than one candidate write instruction: a
//   frequent write plus a rare patch write. The gate tick % 41 == 23
//   fires on about 2 of the 100 repetitions, so the patch write line
//   gets very few chances to fall inside a profiling window. The read
//   end is a single instruction - a read inside a lambda over the
//   value member of a stack union - so only the write end of the
//   dependency can change identity. Distance lever: 256 padding
//   writes, enough to cross the smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The patch write line
//   is expected to be the first edge to disappear from the sampled
//   dependency set, which leaves the same read instruction paired with
//   a smaller set of write instructions than in the baseline.
// ==========================================================

union Slot { short as_value; unsigned char raw[sizeof(short)]; };

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
    Slot slot;
    slot.as_value = 32;                       // Sink (frequent)
    if (tick % 41 == 23) {
        slot.as_value = 39;                   // Sink (rare patch)
    }
    pad_writes(8);
    auto src_lambda = [](const short* source) { return *source; };        // Source
    short observed = src_lambda(&slot.as_value);
    tick = tick + 1;
    (void) observed;
}
