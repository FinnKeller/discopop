// ==========================================================
// Case 595 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a frequent read plus a rare extra read of the same cell
//   Sink   (write): VOLATILE - two write instructions in the arms of a rare/frequent branch
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: two write instructions in the arms
//   of a rare/frequent branch, gated by tick % 31 == 17. On the source
//   side: a frequent read plus a rare extra read of the same cell,
//   gated by tick % 23 == 4. The two periods are coprime, so the rare
//   write and the rare read almost never coincide and the pair of
//   endpoints wanders over four combinations across the 100
//   repetitions. The cell itself is a function local static scalar. No
//   distance lever is used; rarity on both ends carries the case.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The rare arm write
//   line and the extra read line are both expected to be under-
//   reported under sampling, so both the key and the value side of the
//   dependency record change.
// ==========================================================

int main() {
    static int tick = 0;
    static long cell;
    cell = 0;
    if (tick % 31 == 17) {
        cell = 35;                   // Sink (rare arm)
    } else {
        cell = 28;                   // Sink (frequent arm)
    }
    long observed = cell;              // Source (frequent)
    if (tick % 23 == 4) {
        observed += cell;            // Source (rare extra read)
    }
    tick = tick + 1;
    (void) observed;
}
