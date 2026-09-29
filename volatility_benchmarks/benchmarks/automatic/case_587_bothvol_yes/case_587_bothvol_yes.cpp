// ==========================================================
// Case 587 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two read instructions in the arms of a rare/frequent branch
//   Sink   (write): VOLATILE - a frequent write plus a rare patch write
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a frequent write plus a rare patch
//   write, gated by tick % 41 == 23. On the source side: two read
//   instructions in the arms of a rare/frequent branch, gated by tick
//   % 29 == 19. The two periods are coprime, so the rare write and the
//   rare read almost never coincide and the pair of endpoints wanders
//   over four combinations across the 100 repetitions. The cell itself
//   is a stack array element reached by pointer arithmetic. No
//   distance lever is used; rarity on both ends carries the case.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The patch write line
//   and the rare arm read line are both expected to be under-reported
//   under sampling, so both the key and the value side of the
//   dependency record change.
// ==========================================================

int main() {
    static int tick = 0;
    long arr[16];
    long* cursor = arr + 5;
    *cursor = 33;                       // Sink (frequent)
    if (tick % 41 == 23) {
        *cursor = 40;                   // Sink (rare patch)
    }
    long observed = 0;
    if (tick % 29 == 19) {
        observed = *cursor + 1;         // Source (rare arm)
    } else {
        observed = *cursor + 2;         // Source (frequent arm)
    }
    tick = tick + 1;
    (void) observed;
}
