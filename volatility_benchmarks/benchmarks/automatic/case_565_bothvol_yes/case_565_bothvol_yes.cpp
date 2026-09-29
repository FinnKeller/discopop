#include <stdlib.h>

// ==========================================================
// Case 565 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two loop shapes carrying two different read instructions
//   Sink   (write): VOLATILE - a frequent write plus a rare patch write
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a frequent write plus a rare patch
//   write, gated by tick % 19 == 12. On the source side: two loop
//   shapes carrying two different read instructions, gated by tick %
//   29 == 19. The two periods are coprime, so the rare write and the
//   rare read almost never coincide and the pair of endpoints wanders
//   over four combinations across the 100 repetitions. The cell itself
//   is a malloc'ed cell released per repetition. Distance lever: 256
//   padding writes, enough to cross the smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The patch write line
//   and the read line of the rare loop shape are both expected to be
//   under-reported under sampling, so both the key and the value side
//   of the dependency record change.
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
    long long* cell = (long long*) malloc(sizeof(long long));
    *cell = 0;
    *cell = 50;                       // Sink (frequent)
    if (tick % 19 == 12) {
        *cell = 57;                   // Sink (rare patch)
    }
    pad_writes(8);
    long long observed = 0;
    if (tick % 29 == 19) {
        for (int i = 0; i < 16; i += 1) {
            if (i == 7) { observed += *cell; } // Source (rare dense loop)
        }
    } else {
        for (int i = 0; i < 16; i += 7) {
            if (i == 7) { observed += *cell; } // Source (frequent sparse loop)
        }
    }
    tick = tick + 1;
    (void) observed;
    free(cell);
}
