// ==========================================================
// Case 538 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a frequent read plus a rare extra read of the same cell
//   Sink   (write): VOLATILE - a frequent write plus a rare patch write
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a frequent write plus a rare patch
//   write, gated by tick % 19 == 12. On the source side: a frequent
//   read plus a rare extra read of the same cell, gated by tick % 37
//   == 29. The two periods are coprime, so the rare write and the rare
//   read almost never coincide and the pair of endpoints wanders over
//   four combinations across the 100 repetitions. The cell itself is
//   the value member of a stack union. Distance lever: 256 padding
//   reads, enough to cross the smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The patch write line
//   and the extra read line are both expected to be under-reported
//   under sampling, so both the key and the value side of the
//   dependency record change.
// ==========================================================

union Slot { long as_value; unsigned char raw[sizeof(long)]; };

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
    slot.as_value = 50;                       // Sink (frequent)
    if (tick % 19 == 12) {
        slot.as_value = 57;                   // Sink (rare patch)
    }
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    long observed = slot.as_value;              // Source (frequent)
    if (tick % 37 == 29) {
        observed += slot.as_value;            // Source (rare extra read)
    }
    tick = tick + 1;
    (void) observed;
}
