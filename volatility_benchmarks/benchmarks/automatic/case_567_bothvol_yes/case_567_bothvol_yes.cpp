// ==========================================================
// Case 567 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a switch over the tick counter with two rare arms and one default arm
//   Sink   (write): VOLATILE - a frequent write plus a rare patch write
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a frequent write plus a rare patch
//   write, gated by tick % 31 == 17. On the source side: a switch over
//   the tick counter with two rare arms and one default arm, gated by
//   tick % 23 == 11. The two periods are coprime, so the rare write
//   and the rare read almost never coincide and the pair of endpoints
//   wanders over four combinations across the 100 repetitions. The
//   cell itself is a function local static scalar. No distance lever
//   is used; rarity on both ends carries the case.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The patch write line
//   and the two rare arm read lines are both expected to be under-
//   reported under sampling, so both the key and the value side of the
//   dependency record change.
// ==========================================================

int main() {
    static int tick = 0;
    static short cell;
    cell = 0;
    cell = 29;                       // Sink (frequent)
    if (tick % 31 == 17) {
        cell = 36;                   // Sink (rare patch)
    }
    short observed = 0;
    switch (tick % 23) {
    case 11:
        observed = cell + 1;         // Source (rare arm)
        break;
    case 12:
        observed = cell + 2;         // Source (second rare arm)
        break;
    default:
        observed = cell + 3;         // Source (default arm)
        break;
    }
    tick = tick + 1;
    (void) observed;
}
