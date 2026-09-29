// ==========================================================
// Case 573 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a recursive reader that rarely stops one level early, at a different read line
//   Sink   (write): VOLATILE - a recursive writer that rarely stops one level early, at a different write line
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a recursive writer that rarely
//   stops one level early, at a different write line, gated by tick %
//   31 == 7. On the source side: a recursive reader that rarely stops
//   one level early, at a different read line, gated by tick % 41 ==
//   23. The two periods are coprime, so the rare write and the rare
//   read almost never coincide and the pair of endpoints wanders over
//   four combinations across the 100 repetitions. The cell itself is a
//   plain stack scalar. Distance lever: 2560 padding reads, which
//   shift the window phase from repetition to repetition.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The shallow stop
//   write line and the shallow stop read line are both expected to be
//   under-reported under sampling, so both the key and the value side
//   of the dependency record change.
// ==========================================================

static void store_descend(long* target, int depth, int shallow) {
    if (shallow != 0 && depth == 1) {
        *target = 69;               // Sink (rare shallow stop)
        return;
    }
    if (depth == 0) {
        *target = 62;               // Sink (bottom of recursion)
        return;
    }
    store_descend(target, depth - 1, shallow);
}

static int pad_area[64];

static int pad_reads(int rounds) {
    int sum = 0;
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
            sum += pad_area[i];
        }
    }
    return sum;
}

static long load_descend(const long* source, int depth, int shallow) {
    if (shallow != 0 && depth == 1) {
        return *source + 2;         // Source (rare shallow stop)
    }
    if (depth == 0) {
        return *source + 1;         // Source (bottom of recursion)
    }
    return load_descend(source, depth - 1, shallow);
}

int main() {
    static int tick = 0;
    long cell = 0;
    int sink_shallow = (tick % 31 == 7) ? 1 : 0;
    store_descend(&cell, 3, sink_shallow);
    int pad_noise = pad_reads(40);
    (void) pad_noise;
    int src_shallow = (tick % 41 == 23) ? 1 : 0;
    long observed = load_descend(&cell, 3, src_shallow);
    tick = tick + 1;
    (void) observed;
}
