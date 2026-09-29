#include <stdlib.h>

// ==========================================================
// Case 459 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a switch over the tick counter with two rare arms and one default arm
//   Sink   (write): stable   - an assignment through one of two pointers that denote the same object
// Idea:
//   The source end offers more than one candidate read instruction: a
//   switch over the tick counter with two rare arms and one default
//   arm. The gate tick % 23 == 11 fires on about 4 of the 100
//   repetitions, so the two rare arm read lines gets very few chances
//   to fall inside a profiling window. The write end is a single
//   instruction - an assignment through one of two pointers that
//   denote the same object over a malloc'ed cell released per
//   repetition - so only the read end of the dependency can change
//   identity. Distance lever: 256 padding writes, enough to cross the
//   smaller sampling windows. The padding is deliberately placed in
//   front of the write, so that no shadow memory clear can fall
//   between write and read and the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The two rare arm
//   read lines is expected to be the first key to vanish from the
//   sampled dependency file, which leaves the same write instruction
//   paired with a smaller set of read instructions than in the
//   baseline.
// ==========================================================

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
    long* cell = (long*) malloc(sizeof(long));
    *cell = 0;
    pad_writes(8);
    long* alias_a = cell;
    long* alias_b = cell;
    long* chosen = (rand() % 2 == 0) ? alias_a : alias_b;
    *chosen = 26;        // Sink
    long observed = 0;
    switch (tick % 23) {
    case 11:
        observed = *cell + 1;         // Source (rare arm)
        break;
    case 12:
        observed = *cell + 2;         // Source (second rare arm)
        break;
    default:
        observed = *cell + 3;         // Source (default arm)
        break;
    }
    tick = tick + 1;
    (void) observed;
    free(cell);
}
