#include <stdlib.h>

// ==========================================================
// Case 499 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a switch over the tick counter with two rare arms and one default arm
//   Sink   (write): stable   - an assignment through one of two pointers that denote the same object
// Idea:
//   The source end offers more than one candidate read instruction: a
//   switch over the tick counter with two rare arms and one default
//   arm. The gate tick % 31 == 7 fires on about 3 of the 100
//   repetitions, so the two rare arm read lines gets very few chances
//   to fall inside a profiling window. The write end is a single
//   instruction - an assignment through one of two pointers that
//   denote the same object over the value member of a stack union - so
//   only the read end of the dependency can change identity. Distance
//   lever: 256 padding reads, enough to cross the smaller sampling
//   windows. The padding is deliberately placed in front of the write,
//   so that no shadow memory clear can fall between write and read and
//   the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The two rare arm
//   read lines is expected to be the first key to vanish from the
//   sampled dependency file, which leaves the same write instruction
//   paired with a smaller set of read instructions than in the
//   baseline.
// ==========================================================

union Slot { unsigned int as_value; unsigned char raw[sizeof(unsigned int)]; };

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
    Slot slot;
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    unsigned int* alias_a = &slot.as_value;
    unsigned int* alias_b = &slot.as_value;
    unsigned int* chosen = (rand() % 2 == 0) ? alias_a : alias_b;
    *chosen = 43;        // Sink
    unsigned int observed = 0;
    switch (tick % 31) {
    case 7:
        observed = slot.as_value + 1;         // Source (rare arm)
        break;
    case 8:
        observed = slot.as_value + 2;         // Source (second rare arm)
        break;
    default:
        observed = slot.as_value + 3;         // Source (default arm)
        break;
    }
    tick = tick + 1;
    (void) observed;
}
