// ==========================================================
// Case 413 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a plain read
//   Sink   (write): VOLATILE - two write instructions in the arms of a rare/frequent branch
// Idea:
//   The sink end offers more than one candidate write instruction: two
//   write instructions in the arms of a rare/frequent branch. The gate
//   tick % 41 == 23 fires on about 2 of the 100 repetitions, so the
//   rare arm write line gets very few chances to fall inside a
//   profiling window. The read end is a single instruction - a plain
//   read over a stack array element reached by pointer arithmetic - so
//   only the write end of the dependency can change identity. No
//   distance lever is used; rarity alone carries the case.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The rare arm write
//   line is expected to be the first edge to disappear from the
//   sampled dependency set, which leaves the same read instruction
//   paired with a smaller set of write instructions than in the
//   baseline.
// ==========================================================

int main() {
    static int tick = 0;
    int arr[16];
    int* cursor = arr + 5;
    if (tick % 41 == 23) {
        *cursor = 58;                   // Sink (rare arm)
    } else {
        *cursor = 51;                   // Sink (frequent arm)
    }
    int observed = *cursor;        // Source
    tick = tick + 1;
    (void) observed;
}
