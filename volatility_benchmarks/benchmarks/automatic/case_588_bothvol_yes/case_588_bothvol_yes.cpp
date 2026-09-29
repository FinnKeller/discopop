// ==========================================================
// Case 588 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two read instructions in the arms of a rare/frequent branch
//   Sink   (write): VOLATILE - two write instructions in the arms of a rare/frequent branch
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: two write instructions in the arms
//   of a rare/frequent branch, gated by tick % 41 == 23. On the source
//   side: two read instructions in the arms of a rare/frequent branch,
//   gated by tick % 19 == 5. The two periods are coprime, so the rare
//   write and the rare read almost never coincide and the pair of
//   endpoints wanders over four combinations across the 100
//   repetitions. The cell itself is a plain stack scalar. Distance
//   lever: 2560 padding writes, which guarantee a shadow memory clear
//   for every batch size.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The rare arm write
//   line and the rare arm read line are both expected to be under-
//   reported under sampling, so both the key and the value side of the
//   dependency record change.
// ==========================================================

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
    long long cell = 0;
    if (tick % 41 == 23) {
        cell = 33;                   // Sink (rare arm)
    } else {
        cell = 26;                   // Sink (frequent arm)
    }
    pad_writes(40);
    long long observed = 0;
    if (tick % 19 == 5) {
        observed = cell + 1;         // Source (rare arm)
    } else {
        observed = cell + 2;         // Source (frequent arm)
    }
    tick = tick + 1;
    (void) observed;
}
