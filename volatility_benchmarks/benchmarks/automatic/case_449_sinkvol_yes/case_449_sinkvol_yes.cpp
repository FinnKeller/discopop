// ==========================================================
// Case 449 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read through a local pointer
//   Sink   (write): VOLATILE - a switch over the tick counter with two rare arms and one default arm
// Idea:
//   The sink end offers more than one candidate write instruction: a
//   switch over the tick counter with two rare arms and one default
//   arm. The gate tick % 41 == 13 fires on about 2 of the 100
//   repetitions, so the two rare arm write lines gets very few chances
//   to fall inside a profiling window. The read end is a single
//   instruction - a read through a local pointer over a plain stack
//   scalar - so only the write end of the dependency can change
//   identity. No distance lever is used; rarity alone carries the
//   case.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The two rare arm
//   write lines is expected to be the first edge to disappear from the
//   sampled dependency set, which leaves the same read instruction
//   paired with a smaller set of write instructions than in the
//   baseline.
// ==========================================================

int main() {
    static int tick = 0;
    unsigned int cell = 0;
    switch (tick % 41) {
    case 13:
        cell = 48;                   // Sink (rare arm)
        break;
    case 14:
        cell = 54;                   // Sink (second rare arm)
        break;
    default:
        cell = 41;                   // Sink (default arm)
        break;
    }
    const unsigned int* src_ptr = &cell;
    unsigned int observed = *src_ptr;        // Source
    tick = tick + 1;
    (void) observed;
}
