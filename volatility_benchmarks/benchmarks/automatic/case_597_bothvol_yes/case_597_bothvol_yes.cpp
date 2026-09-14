// ==========================================================
// Case 597 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a recursive reader that rarely stops one level early, at a different read line
//   Sink   (write): VOLATILE - a frequent write plus a rare patch write
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a frequent write plus a rare patch
//   write, gated by tick % 37 == 29. On the source side: a recursive
//   reader that rarely stops one level early, at a different read
//   line, gated by tick % 31 == 7. The two periods are coprime, so the
//   rare write and the rare read almost never coincide and the pair of
//   endpoints wanders over four combinations across the 100
//   repetitions. The cell itself is a heap cell allocated and released
//   per repetition. Distance lever: 2560 padding reads, which shift
//   the window phase from repetition to repetition.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The patch write line
//   and the shallow stop read line are both expected to be under-
//   reported under sampling, so both the key and the value side of the
//   dependency record change.
// ==========================================================

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

static long long load_descend(const long long* source, int depth, int shallow) {
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
    long long* cell = new long long(0);
    *cell = 42;                       // Sink (frequent)
    if (tick % 37 == 29) {
        *cell = 49;                   // Sink (rare patch)
    }
    int pad_noise = pad_reads(40);
    (void) pad_noise;
    int src_shallow = (tick % 31 == 7) ? 1 : 0;
    long long observed = load_descend(cell, 3, src_shallow);
    tick = tick + 1;
    (void) observed;
    delete cell;
}
