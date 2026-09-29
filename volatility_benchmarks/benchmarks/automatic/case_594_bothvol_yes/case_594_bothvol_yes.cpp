// ==========================================================
// Case 594 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two read instructions in the arms of a rare/frequent branch
//   Sink   (write): VOLATILE - a switch over the tick counter with two rare arms and one default arm
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a switch over the tick counter with
//   two rare arms and one default arm, gated by tick % 37 == 11. On
//   the source side: two read instructions in the arms of a
//   rare/frequent branch, gated by tick % 29 == 19. The two periods
//   are coprime, so the rare write and the rare read almost never
//   coincide and the pair of endpoints wanders over four combinations
//   across the 100 repetitions. The cell itself is the value member of
//   a stack union. Distance lever: 256 padding writes, enough to cross
//   the smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The two rare arm
//   write lines and the rare arm read line are both expected to be
//   under-reported under sampling, so both the key and the value side
//   of the dependency record change.
// ==========================================================

union Slot { int as_value; unsigned char raw[sizeof(int)]; };

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
    switch (tick % 37) {
    case 11:
        slot.as_value = 28;                   // Sink (rare arm)
        break;
    case 12:
        slot.as_value = 34;                   // Sink (second rare arm)
        break;
    default:
        slot.as_value = 21;                   // Sink (default arm)
        break;
    }
    pad_writes(8);
    int observed = 0;
    if (tick % 29 == 19) {
        observed = slot.as_value + 1;         // Source (rare arm)
    } else {
        observed = slot.as_value + 2;         // Source (frequent arm)
    }
    tick = tick + 1;
    (void) observed;
}
