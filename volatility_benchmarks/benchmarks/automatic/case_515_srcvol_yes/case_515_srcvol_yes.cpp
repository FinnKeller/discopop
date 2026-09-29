#include <stdlib.h>

// ==========================================================
// Case 515 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - two loop shapes carrying two different read instructions
//   Sink   (write): stable   - an assignment through one of two pointers that denote the same object
// Idea:
//   The source end offers more than one candidate read instruction:
//   two loop shapes carrying two different read instructions. The gate
//   tick % 23 == 11 fires on about 4 of the 100 repetitions, so the
//   read line of the rare loop shape gets very few chances to fall
//   inside a profiling window. The write end is a single instruction -
//   an assignment through one of two pointers that denote the same
//   object over a function local static scalar - so only the read end
//   of the dependency can change identity. Distance lever: 256 padding
//   reads, enough to cross the smaller sampling windows. The padding
//   is deliberately placed in front of the write, so that no shadow
//   memory clear can fall between write and read and the sink end
//   stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The read line of the
//   rare loop shape is expected to be the first key to vanish from the
//   sampled dependency file, which leaves the same write instruction
//   paired with a smaller set of read instructions than in the
//   baseline.
// ==========================================================

static int pad_area[32];

static int pad_reads(int rounds) {
    int sum = 0;
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 32; ++i) {
            sum += pad_area[i];
        }
    }
    return sum;
}

int main() {
    static int tick = 0;
    static short cell;
    cell = 0;
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    short* alias_a = &cell;
    short* alias_b = &cell;
    short* chosen = (rand() % 2 == 0) ? alias_a : alias_b;
    *chosen = 57;        // Sink
    short observed = 0;
    if (tick % 23 == 11) {
        for (int i = 0; i < 16; i += 1) {
            if (i == 7) { observed += cell; } // Source (rare dense loop)
        }
    } else {
        for (int i = 0; i < 16; i += 7) {
            if (i == 7) { observed += cell; } // Source (frequent sparse loop)
        }
    }
    tick = tick + 1;
    (void) observed;
}
