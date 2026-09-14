#include <stdlib.h>

// ==========================================================
// Case 455 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a recursive reader that rarely stops one level early, at a different read line
//   Sink   (write): stable   - an assignment through one of two pointers that denote the same object
// Idea:
//   The source end offers more than one candidate read instruction: a
//   recursive reader that rarely stops one level early, at a different
//   read line. The gate tick % 37 == 29 fires on about 2 of the 100
//   repetitions, so the shallow stop read line gets very few chances
//   to fall inside a profiling window. The write end is a single
//   instruction - an assignment through one of two pointers that
//   denote the same object over a plain stack scalar - so only the
//   read end of the dependency can change identity. Distance lever:
//   256 padding reads, enough to cross the smaller sampling windows.
//   The padding is deliberately placed in front of the write, so that
//   no shadow memory clear can fall between write and read and the
//   sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The shallow stop
//   read line is expected to be the first key to vanish from the
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

static long load_descend(const long* source, int depth, int shallow) {
    if (shallow != 0 && depth == 1) {
        return *source + 2;         // Source (rare shallow stop)
    }
    if (depth == 0) {
        return *source + 1;         // Source (bottom of recursion)
    }
    return load_descend(source, depth - 1, shallow);
}

int main() {
    static int tick = 0;
    long cell = 0;
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    long* alias_a = &cell;
    long* alias_b = &cell;
    long* chosen = (rand() % 2 == 0) ? alias_a : alias_b;
    *chosen = 51;        // Sink
    int src_shallow = (tick % 37 == 29) ? 1 : 0;
    long observed = load_descend(&cell, 3, src_shallow);
    tick = tick + 1;
    (void) observed;
}
