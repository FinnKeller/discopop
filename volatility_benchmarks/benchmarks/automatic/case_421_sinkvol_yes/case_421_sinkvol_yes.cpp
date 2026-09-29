// ==========================================================
// Case 421 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a plain read
//   Sink   (write): VOLATILE - two write instructions in the arms of a rare/frequent branch
// Idea:
//   The sink end offers more than one candidate write instruction: two
//   write instructions in the arms of a rare/frequent branch. The gate
//   tick % 37 == 29 fires on about 2 of the 100 repetitions, so the
//   rare arm write line gets very few chances to fall inside a
//   profiling window. The read end is a single instruction - a plain
//   read over one element of a stack array - so only the write end of
//   the dependency can change identity. Distance lever: 256 padding
//   writes, enough to cross the smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The rare arm write
//   line is expected to be the first edge to disappear from the
//   sampled dependency set, which leaves the same read instruction
//   paired with a smaller set of write instructions than in the
//   baseline.
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
    long long arr[16];
    if (tick % 37 == 29) {
        arr[7] = 55;                   // Sink (rare arm)
    } else {
        arr[7] = 48;                   // Sink (frequent arm)
    }
    pad_writes(8);
    long long observed = arr[7];        // Source
    tick = tick + 1;
    (void) observed;
}
