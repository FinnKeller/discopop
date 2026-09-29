// ==========================================================
// Case 528 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two read instructions in the arms of a rare/frequent branch
//   Sink   (write): VOLATILE - a frequent write plus a rare patch write
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a frequent write plus a rare patch
//   write, gated by tick % 41 == 23. On the source side: two read
//   instructions in the arms of a rare/frequent branch, gated by tick
//   % 19 == 5. The two periods are coprime, so the rare write and the
//   rare read almost never coincide and the pair of endpoints wanders
//   over four combinations across the 100 repetitions. The cell itself
//   is one element of a stack array. Distance lever: 2560 padding
//   reads, which shift the window phase from repetition to repetition.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The patch write line
//   and the rare arm read line are both expected to be under-reported
//   under sampling, so both the key and the value side of the
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

int main() {
    static int tick = 0;
    short arr[16];
    arr[7] = 30;                       // Sink (frequent)
    if (tick % 41 == 23) {
        arr[7] = 37;                   // Sink (rare patch)
    }
    int pad_noise = pad_reads(40);
    (void) pad_noise;
    short observed = 0;
    if (tick % 19 == 5) {
        observed = arr[7] + 1;         // Source (rare arm)
    } else {
        observed = arr[7] + 2;         // Source (frequent arm)
    }
    tick = tick + 1;
    (void) observed;
}
