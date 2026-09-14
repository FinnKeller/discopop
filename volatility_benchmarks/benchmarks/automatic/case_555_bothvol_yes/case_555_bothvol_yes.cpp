// ==========================================================
// Case 555 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a switch over the tick counter with two rare arms and one default arm
//   Sink   (write): VOLATILE - a frequent write plus a rare patch write
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a frequent write plus a rare patch
//   write, gated by tick % 41 == 23. On the source side: a switch over
//   the tick counter with two rare arms and one default arm, gated by
//   tick % 23 == 11. The two periods are coprime, so the rare write
//   and the rare read almost never coincide and the pair of endpoints
//   wanders over four combinations across the 100 repetitions. The
//   cell itself is one element of a stack array. No distance lever is
//   used; rarity on both ends carries the case.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The patch write line
//   and the two rare arm read lines are both expected to be under-
//   reported under sampling, so both the key and the value side of the
//   dependency record change.
// ==========================================================

int main() {
    static int tick = 0;
    short arr[16];
    arr[7] = 35;                       // Sink (frequent)
    if (tick % 41 == 23) {
        arr[7] = 42;                   // Sink (rare patch)
    }
    short observed = 0;
    switch (tick % 23) {
    case 11:
        observed = arr[7] + 1;         // Source (rare arm)
        break;
    case 12:
        observed = arr[7] + 2;         // Source (second rare arm)
        break;
    default:
        observed = arr[7] + 3;         // Source (default arm)
        break;
    }
    tick = tick + 1;
    (void) observed;
}
