#include <stdlib.h>

// ==========================================================
// Case 483 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a frequent read plus a rare extra read of the same cell
//   Sink   (write): stable   - an assignment through one of two pointers that denote the same object
// Idea:
//   The source end offers more than one candidate read instruction: a
//   frequent read plus a rare extra read of the same cell. The gate
//   tick % 41 == 23 fires on about 2 of the 100 repetitions, so the
//   extra read line gets very few chances to fall inside a profiling
//   window. The write end is a single instruction - an assignment
//   through one of two pointers that denote the same object over the
//   value member of a stack union - so only the read end of the
//   dependency can change identity. Distance lever: 2560 padding
//   reads, which shift the window phase from repetition to repetition.
//   The padding is deliberately placed in front of the write, so that
//   no shadow memory clear can fall between write and read and the
//   sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The extra read line
//   is expected to be the first key to vanish from the sampled
//   dependency file, which leaves the same write instruction paired
//   with a smaller set of read instructions than in the baseline.
// ==========================================================

union Slot { char as_value; unsigned char raw[sizeof(char)]; };

static int pad_area[64];

static int pad_reads(int rounds) {
    int sum = 0;
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
            sum += pad_area[i];
        }
    }
    return sum;
}

int main() {
    static int tick = 0;
    Slot slot;
    int pad_noise = pad_reads(40);
    (void) pad_noise;
    char* alias_a = &slot.as_value;
    char* alias_b = &slot.as_value;
    char* chosen = (rand() % 2 == 0) ? alias_a : alias_b;
    *chosen = 45;        // Sink
    char observed = slot.as_value;              // Source (frequent)
    if (tick % 41 == 23) {
        observed += slot.as_value;            // Source (rare extra read)
    }
    tick = tick + 1;
    (void) observed;
}
