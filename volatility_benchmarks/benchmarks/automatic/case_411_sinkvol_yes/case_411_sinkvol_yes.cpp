// ==========================================================
// Case 411 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read inside a reader function
//   Sink   (write): VOLATILE - a recursive writer that rarely stops one level early, at a different write line
// Idea:
//   The sink end offers more than one candidate write instruction: a
//   recursive writer that rarely stops one level early, at a different
//   write line. The gate tick % 37 == 11 fires on about 2 of the 100
//   repetitions, so the shallow stop write line gets very few chances
//   to fall inside a profiling window. The read end is a single
//   instruction - a read inside a reader function over a function
//   local static scalar - so only the write end of the dependency can
//   change identity. Distance lever: 256 padding reads, enough to
//   cross the smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The shallow stop
//   write line is expected to be the first edge to disappear from the
//   sampled dependency set, which leaves the same read instruction
//   paired with a smaller set of write instructions than in the
//   baseline.
// ==========================================================

static void store_descend(unsigned int* target, int depth, int shallow) {
    if (shallow != 0 && depth == 1) {
        *target = 58;               // Sink (rare shallow stop)
        return;
    }
    if (depth == 0) {
        *target = 51;               // Sink (bottom of recursion)
        return;
    }
    store_descend(target, depth - 1, shallow);
}

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

static unsigned int load_value(const unsigned int* source) {
    return *source;        // Source
}

int main() {
    static int tick = 0;
    static unsigned int cell;
    cell = 0;
    int sink_shallow = (tick % 37 == 11) ? 1 : 0;
    store_descend(&cell, 3, sink_shallow);
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    unsigned int observed = load_value(&cell);
    tick = tick + 1;
    (void) observed;
}
