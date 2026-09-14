// ==========================================================
// Case 447 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a plain read
//   Sink   (write): VOLATILE - a recursive writer that rarely stops one level early, at a different write line
// Idea:
//   The sink end offers more than one candidate write instruction: a
//   recursive writer that rarely stops one level early, at a different
//   write line. The gate tick % 29 == 9 fires on about 3 of the 100
//   repetitions, so the shallow stop write line gets very few chances
//   to fall inside a profiling window. The read end is a single
//   instruction - a plain read over a function local static scalar -
//   so only the write end of the dependency can change identity.
//   Distance lever: 2560 padding writes, which guarantee a shadow
//   memory clear for every batch size.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The shallow stop
//   write line is expected to be the first edge to disappear from the
//   sampled dependency set, which leaves the same read instruction
//   paired with a smaller set of write instructions than in the
//   baseline.
// ==========================================================

static void store_descend(long long* target, int depth, int shallow) {
    if (shallow != 0 && depth == 1) {
        *target = 59;               // Sink (rare shallow stop)
        return;
    }
    if (depth == 0) {
        *target = 52;               // Sink (bottom of recursion)
        return;
    }
    store_descend(target, depth - 1, shallow);
}

static int pad_area[64];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
            pad_area[i] = r ^ i;
        }
    }
}

int main() {
    static int tick = 0;
    static long long cell;
    cell = 0;
    int sink_shallow = (tick % 29 == 9) ? 1 : 0;
    store_descend(&cell, 3, sink_shallow);
    pad_writes(40);
    long long observed = cell;        // Source
    tick = tick + 1;
    (void) observed;
}
