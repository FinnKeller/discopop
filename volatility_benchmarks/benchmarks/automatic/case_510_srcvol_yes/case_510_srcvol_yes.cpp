#include <stdlib.h>

// ==========================================================
// Case 510 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a switch over the tick counter with two rare arms and one default arm
//   Sink   (write): stable   - an assignment reached through a randomly indexed table whose slots are all the same function
// Idea:
//   The source end offers more than one candidate read instruction: a
//   switch over the tick counter with two rare arms and one default
//   arm. The gate tick % 29 == 9 fires on about 3 of the 100
//   repetitions, so the two rare arm read lines gets very few chances
//   to fall inside a profiling window. The write end is a single
//   instruction - an assignment reached through a randomly indexed
//   table whose slots are all the same function over a heap cell whose
//   address moves every repetition - so only the read end of the
//   dependency can change identity. Distance lever: 2560 padding
//   reads, which shift the window phase from repetition to repetition.
//   The padding is deliberately placed in front of the write, so that
//   no shadow memory clear can fall between write and read and the
//   sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The two rare arm
//   read lines is expected to be the first key to vanish from the
//   sampled dependency file, which leaves the same write instruction
//   paired with a smaller set of read instructions than in the
//   baseline.
// ==========================================================

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

static void store_value(long long* target) {
    *target = 72;        // Sink
}

int main() {
    static int tick = 0;
    long long* cell = new long long(0);
    int pad_noise = pad_reads(40);
    (void) pad_noise;
    void (*sink_table[4])(long long*) = { store_value, store_value, store_value, store_value };
    sink_table[rand() % 4](cell);
    long long observed = 0;
    switch (tick % 29) {
    case 9:
        observed = *cell + 1;         // Source (rare arm)
        break;
    case 10:
        observed = *cell + 2;         // Source (second rare arm)
        break;
    default:
        observed = *cell + 3;         // Source (default arm)
        break;
    }
    tick = tick + 1;
    (void) observed;
}
