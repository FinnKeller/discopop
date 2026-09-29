// ==========================================================
// Case 530 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two aliases of the same cell, the second one read only rarely
//   Sink   (write): VOLATILE - a switch over the tick counter with two rare arms and one default arm
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a switch over the tick counter with
//   two rare arms and one default arm, gated by tick % 41 == 23. On
//   the source side: two aliases of the same cell, the second one read
//   only rarely, gated by tick % 31 == 17. The two periods are
//   coprime, so the rare write and the rare read almost never coincide
//   and the pair of endpoints wanders over four combinations across
//   the 100 repetitions. The cell itself is the value member of a
//   stack union. Distance lever: 256 padding writes, enough to cross
//   the smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The two rare arm
//   write lines and the read line through the rare alias are both
//   expected to be under-reported under sampling, so both the key and
//   the value side of the dependency record change.
// ==========================================================

union Slot { long as_value; unsigned char raw[sizeof(long)]; };

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
    Slot slot;
    switch (tick % 41) {
    case 23:
        slot.as_value = 35;                   // Sink (rare arm)
        break;
    case 24:
        slot.as_value = 41;                   // Sink (second rare arm)
        break;
    default:
        slot.as_value = 28;                   // Sink (default arm)
        break;
    }
    pad_writes(8);
    const long* src_alias_main = &slot.as_value;
    const long* src_alias_rare = &slot.as_value;
    long observed = 0;
    if (tick % 31 == 17) {
        observed = *src_alias_rare;    // Source (rare alias)
    } else {
        observed = *src_alias_main;    // Source (frequent alias)
    }
    tick = tick + 1;
    (void) observed;
}
