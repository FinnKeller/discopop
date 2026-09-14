// ==========================================================
// Case 583 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a switch over the tick counter with two rare arms and one default arm
//   Sink   (write): VOLATILE - two write instructions in the arms of a rare/frequent branch
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: two write instructions in the arms
//   of a rare/frequent branch, gated by tick % 41 == 23. On the source
//   side: a switch over the tick counter with two rare arms and one
//   default arm, gated by tick % 19 == 5. The two periods are coprime,
//   so the rare write and the rare read almost never coincide and the
//   pair of endpoints wanders over four combinations across the 100
//   repetitions. The cell itself is one element of a stack array. No
//   distance lever is used; rarity on both ends carries the case.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The rare arm write
//   line and the two rare arm read lines are both expected to be
//   under-reported under sampling, so both the key and the value side
//   of the dependency record change.
// ==========================================================

int main() {
    static int tick = 0;
    long arr[16];
    if (tick % 41 == 23) {
        arr[7] = 47;                   // Sink (rare arm)
    } else {
        arr[7] = 40;                   // Sink (frequent arm)
    }
    long observed = 0;
    switch (tick % 19) {
    case 5:
        observed = arr[7] + 1;         // Source (rare arm)
        break;
    case 6:
        observed = arr[7] + 2;         // Source (second rare arm)
        break;
    default:
        observed = arr[7] + 3;         // Source (default arm)
        break;
    }
    tick = tick + 1;
    (void) observed;
}
