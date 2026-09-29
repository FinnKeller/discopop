// ==========================================================
// Case 433 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read through a local pointer
//   Sink   (write): VOLATILE - two write instructions in the arms of a rare/frequent branch
// Idea:
//   The sink end offers more than one candidate write instruction: two
//   write instructions in the arms of a rare/frequent branch. The gate
//   tick % 37 == 29 fires on about 2 of the 100 repetitions, so the
//   rare arm write line gets very few chances to fall inside a
//   profiling window. The read end is a single instruction - a read
//   through a local pointer over a function local static scalar - so
//   only the write end of the dependency can change identity. Distance
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

int main() {
    static int tick = 0;
    static unsigned int cell;
    cell = 0;
    if (tick % 37 == 29) {
        cell = 40;                   // Sink (rare arm)
    } else {
        cell = 33;                   // Sink (frequent arm)
    }
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    const unsigned int* src_ptr = &cell;
    unsigned int observed = *src_ptr;        // Source
    tick = tick + 1;
    (void) observed;
}
