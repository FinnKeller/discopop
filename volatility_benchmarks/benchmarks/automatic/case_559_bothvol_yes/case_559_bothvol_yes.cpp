// ==========================================================
// Case 559 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a switch over the tick counter with two rare arms and one default arm
//   Sink   (write): VOLATILE - a switch over the tick counter with two rare arms and one default arm
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a switch over the tick counter with
//   two rare arms and one default arm, gated by tick % 41 == 13. On
//   the source side: a switch over the tick counter with two rare arms
//   and one default arm, gated by tick % 23 == 11. The two periods are
//   coprime, so the rare write and the rare read almost never coincide
//   and the pair of endpoints wanders over four combinations across
//   the 100 repetitions. The cell itself is a translation unit global
//   scalar. No distance lever is used; rarity on both ends carries the
//   case.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The two rare arm
//   write lines and the two rare arm read lines are both expected to
//   be under-reported under sampling, so both the key and the value
//   side of the dependency record change.
// ==========================================================

static short g_cell;

int main() {
    static int tick = 0;
    g_cell = 0;
    switch (tick % 41) {
    case 13:
        g_cell = 69;                   // Sink (rare arm)
        break;
    case 14:
        g_cell = 75;                   // Sink (second rare arm)
        break;
    default:
        g_cell = 62;                   // Sink (default arm)
        break;
    }
    short observed = 0;
    switch (tick % 23) {
    case 11:
        observed = g_cell + 1;         // Source (rare arm)
        break;
    case 12:
        observed = g_cell + 2;         // Source (second rare arm)
        break;
    default:
        observed = g_cell + 3;         // Source (default arm)
        break;
    }
    tick = tick + 1;
    (void) observed;
}
