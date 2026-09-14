// ==========================================================
// Case 505 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - two read instructions in the arms of a rare/frequent branch
//   Sink   (write): stable   - an assignment reached through a function pointer with a single target
// Idea:
//   The source end offers more than one candidate read instruction:
//   two read instructions in the arms of a rare/frequent branch. The
//   gate tick % 37 == 11 fires on about 2 of the 100 repetitions, so
//   the rare arm read line gets very few chances to fall inside a
//   profiling window. The write end is a single instruction - an
//   assignment reached through a function pointer with a single target
//   over a stack array element reached by pointer arithmetic - so only
//   the read end of the dependency can change identity. Distance
//   lever: 2560 padding reads, which shift the window phase from
//   repetition to repetition. The padding is deliberately placed in
//   front of the write, so that no shadow memory clear can fall
//   between write and read and the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The rare arm read
//   line is expected to be the first key to vanish from the sampled
//   dependency file, which leaves the same write instruction paired
//   with a smaller set of read instructions than in the baseline.
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

static void store_value(short* target) {
    *target = 57;        // Sink
}

int main() {
    static int tick = 0;
    short arr[16];
    short* cursor = arr + 5;
    int pad_noise = pad_reads(40);
    (void) pad_noise;
    void (*sink_fp)(short*) = store_value;
    sink_fp(cursor);
    short observed = 0;
    if (tick % 37 == 11) {
        observed = *cursor + 1;         // Source (rare arm)
    } else {
        observed = *cursor + 2;         // Source (frequent arm)
    }
    tick = tick + 1;
    (void) observed;
}
