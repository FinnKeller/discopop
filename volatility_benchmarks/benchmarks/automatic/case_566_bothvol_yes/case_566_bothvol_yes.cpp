// ==========================================================
// Case 566 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a switch over the tick counter with two rare arms and one default arm
//   Sink   (write): VOLATILE - two write instructions in the arms of a rare/frequent branch
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: two write instructions in the arms
//   of a rare/frequent branch, gated by tick % 31 == 17. On the source
//   side: a switch over the tick counter with two rare arms and one
//   default arm, gated by tick % 23 == 4. The two periods are coprime,
//   so the rare write and the rare read almost never coincide and the
//   pair of endpoints wanders over four combinations across the 100
//   repetitions. The cell itself is the value member of a stack union.
//   Distance lever: 256 padding reads, enough to cross the smaller
//   sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The rare arm write
//   line and the two rare arm read lines are both expected to be
//   under-reported under sampling, so both the key and the value side
//   of the dependency record change.
// ==========================================================

union Slot { long long as_value; unsigned char raw[sizeof(long long)]; };

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
    Slot slot;
    if (tick % 31 == 17) {
        slot.as_value = 68;                   // Sink (rare arm)
    } else {
        slot.as_value = 61;                   // Sink (frequent arm)
    }
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    long long observed = 0;
    switch (tick % 23) {
    case 4:
        observed = slot.as_value + 1;         // Source (rare arm)
        break;
    case 5:
        observed = slot.as_value + 2;         // Source (second rare arm)
        break;
    default:
        observed = slot.as_value + 3;         // Source (default arm)
        break;
    }
    tick = tick + 1;
    (void) observed;
}
