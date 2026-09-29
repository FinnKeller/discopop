// ==========================================================
// Case 382 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read two call levels down
//   Sink   (write): VOLATILE - two write instructions in the arms of a rare/frequent branch
// Idea:
//   The sink end offers more than one candidate write instruction: two
//   write instructions in the arms of a rare/frequent branch. The gate
//   tick % 31 == 17 fires on about 3 of the 100 repetitions, so the
//   rare arm write line gets very few chances to fall inside a
//   profiling window. The read end is a single instruction - a read
//   two call levels down over one element of a stack array - so only
//   the write end of the dependency can change identity. Distance
//   lever: 256 padding reads, enough to cross the smaller sampling
//   windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The rare arm write
//   line is expected to be the first edge to disappear from the
//   sampled dependency set, which leaves the same read instruction
//   paired with a smaller set of write instructions than in the
//   baseline.
// ==========================================================

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

static long load_inner(const long* source) {
    return *source;        // Source
}

static long load_outer(const long* source) {
    return load_inner(source);
}

int main() {
    static int tick = 0;
    long arr[16];
    if (tick % 31 == 17) {
        arr[7] = 52;                   // Sink (rare arm)
    } else {
        arr[7] = 45;                   // Sink (frequent arm)
    }
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    long observed = load_outer(&arr[7]);
    tick = tick + 1;
    (void) observed;
}
