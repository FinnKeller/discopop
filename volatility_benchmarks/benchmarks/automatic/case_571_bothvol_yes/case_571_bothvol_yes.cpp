// ==========================================================
// Case 571 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two read instructions in the arms of a rare/frequent branch
//   Sink   (write): VOLATILE - a frequent write plus a rare patch write
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a frequent write plus a rare patch
//   write, gated by tick % 37 == 11. On the source side: two read
//   instructions in the arms of a rare/frequent branch, gated by tick
//   % 41 == 13. The two periods are coprime, so the rare write and the
//   rare read almost never coincide and the pair of endpoints wanders
//   over four combinations across the 100 repetitions. The cell itself
//   is a function local static scalar. Distance lever: 256 padding
//   writes, enough to cross the smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The patch write line
//   and the rare arm read line are both expected to be under-reported
//   under sampling, so both the key and the value side of the
//   dependency record change.
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
    static unsigned int cell;
    cell = 0;
    cell = 24;                       // Sink (frequent)
    if (tick % 37 == 11) {
        cell = 31;                   // Sink (rare patch)
    }
    pad_writes(8);
    unsigned int observed = 0;
    if (tick % 41 == 13) {
        observed = cell + 1;         // Source (rare arm)
    } else {
        observed = cell + 2;         // Source (frequent arm)
    }
    tick = tick + 1;
    (void) observed;
}
