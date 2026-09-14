// ==========================================================
// Case 568 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two read instructions in the arms of a rare/frequent branch
//   Sink   (write): VOLATILE - a frequent write plus a rare patch write
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a frequent write plus a rare patch
//   write, gated by tick % 23 == 4. On the source side: two read
//   instructions in the arms of a rare/frequent branch, gated by tick
//   % 41 == 13. The two periods are coprime, so the rare write and the
//   rare read almost never coincide and the pair of endpoints wanders
//   over four combinations across the 100 repetitions. The cell itself
//   is a stack array element reached by pointer arithmetic. Distance
//   lever: 2560 padding writes, which guarantee a shadow memory clear
//   for every batch size.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The patch write line
//   and the rare arm read line are both expected to be under-reported
//   under sampling, so both the key and the value side of the
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
    short arr[16];
    short* cursor = arr + 5;
    *cursor = 33;                       // Sink (frequent)
    if (tick % 23 == 4) {
        *cursor = 40;                   // Sink (rare patch)
    }
    pad_writes(40);
    short observed = 0;
    if (tick % 41 == 13) {
        observed = *cursor + 1;         // Source (rare arm)
    } else {
        observed = *cursor + 2;         // Source (frequent arm)
    }
    tick = tick + 1;
    (void) observed;
}
