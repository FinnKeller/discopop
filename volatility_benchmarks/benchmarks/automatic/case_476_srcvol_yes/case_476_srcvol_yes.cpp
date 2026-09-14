#include <stdlib.h>

// ==========================================================
// Case 476 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a switch over the tick counter with two rare arms and one default arm
//   Sink   (write): stable   - a plain assignment
// Idea:
//   The source end offers more than one candidate read instruction: a
//   switch over the tick counter with two rare arms and one default
//   arm. The gate tick % 37 == 11 fires on about 2 of the 100
//   repetitions, so the two rare arm read lines gets very few chances
//   to fall inside a profiling window. The write end is a single
//   instruction - a plain assignment over a stack array element whose
//   index is drawn once and shared by both ends - so only the read end
//   of the dependency can change identity. No distance lever is used;
//   rarity alone carries the case. The padding is deliberately placed
//   in front of the write, so that no shadow memory clear can fall
//   between write and read and the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The two rare arm
//   read lines is expected to be the first key to vanish from the
//   sampled dependency file, which leaves the same write instruction
//   paired with a smaller set of read instructions than in the
//   baseline.
// ==========================================================

int main() {
    static int tick = 0;
    long arr[16];
    int idx = rand() % 16;
    arr[idx] = 66;        // Sink
    long observed = 0;
    switch (tick % 37) {
    case 11:
        observed = arr[idx] + 1;         // Source (rare arm)
        break;
    case 12:
        observed = arr[idx] + 2;         // Source (second rare arm)
        break;
    default:
        observed = arr[idx] + 3;         // Source (default arm)
        break;
    }
    tick = tick + 1;
    (void) observed;
}
