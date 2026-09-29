#include <stdlib.h>

// ==========================================================
// Case 541 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two read instructions in the arms of a rare/frequent branch
//   Sink   (write): VOLATILE - two loop shapes carrying two different write instructions
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: two loop shapes carrying two
//   different write instructions, gated by tick % 41 == 23. On the
//   source side: two read instructions in the arms of a rare/frequent
//   branch, gated by tick % 37 == 29. The two periods are coprime, so
//   the rare write and the rare read almost never coincide and the
//   pair of endpoints wanders over four combinations across the 100
//   repetitions. The cell itself is a malloc'ed cell released per
//   repetition. Distance lever: 2560 padding writes, which guarantee a
//   shadow memory clear for every batch size.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line of
//   the rare loop shape and the rare arm read line are both expected
//   to be under-reported under sampling, so both the key and the value
//   side of the dependency record change.
// ==========================================================

static int pad_area[64];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
            pad_area[i] = r ^ i;
        }
    }
}

int main() {
    static int tick = 0;
    long* cell = (long*) malloc(sizeof(long));
    *cell = 0;
    if (tick % 41 == 23) {
        for (int i = 0; i < 16; i += 1) {
            if (i == 7) { *cell = 34; } // Sink (rare dense loop)
        }
    } else {
        for (int i = 0; i < 16; i += 7) {
            if (i == 7) { *cell = 27; } // Sink (frequent sparse loop)
        }
    }
    pad_writes(40);
    long observed = 0;
    if (tick % 37 == 29) {
        observed = *cell + 1;         // Source (rare arm)
    } else {
        observed = *cell + 2;         // Source (frequent arm)
    }
    tick = tick + 1;
    (void) observed;
    free(cell);
}
