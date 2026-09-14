// ==========================================================
// Case 535 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two read instructions in the arms of a rare/frequent branch
//   Sink   (write): VOLATILE - a frequent write plus a rare patch write
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a frequent write plus a rare patch
//   write, gated by tick % 31 == 7. On the source side: two read
//   instructions in the arms of a rare/frequent branch, gated by tick
//   % 29 == 9. The two periods are coprime, so the rare write and the
//   rare read almost never coincide and the pair of endpoints wanders
//   over four combinations across the 100 repetitions. The cell itself
//   is one element of a stack array. Distance lever: 256 padding
//   reads, enough to cross the smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The patch write line
//   and the rare arm read line are both expected to be under-reported
//   under sampling, so both the key and the value side of the
//   dependency record change.
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
    char arr[16];
    arr[7] = 30;                       // Sink (frequent)
    if (tick % 31 == 7) {
        arr[7] = 37;                   // Sink (rare patch)
    }
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    char observed = 0;
    if (tick % 29 == 9) {
        observed = arr[7] + 1;         // Source (rare arm)
    } else {
        observed = arr[7] + 2;         // Source (frequent arm)
    }
    tick = tick + 1;
    (void) observed;
}
