// ==========================================================
// Case 509 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a switch over the tick counter with two rare arms and one default arm
//   Sink   (write): stable   - an assignment reached through a function pointer with a single target
// Idea:
//   The source end offers more than one candidate read instruction: a
//   switch over the tick counter with two rare arms and one default
//   arm. The gate tick % 23 == 4 fires on about 4 of the 100
//   repetitions, so the two rare arm read lines gets very few chances
//   to fall inside a profiling window. The write end is a single
//   instruction - an assignment reached through a function pointer
//   with a single target over a stack array element reached by pointer
//   arithmetic - so only the read end of the dependency can change
//   identity. Distance lever: 2560 padding writes, which guarantee a
//   shadow memory clear for every batch size. The padding is
//   deliberately placed in front of the write, so that no shadow
//   memory clear can fall between write and read and the sink end
//   stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The two rare arm
//   read lines is expected to be the first key to vanish from the
//   sampled dependency file, which leaves the same write instruction
//   paired with a smaller set of read instructions than in the
//   baseline.
// ==========================================================

static int pad_area[64];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
            pad_area[i] = r ^ i;
        }
    }
}

static void store_value(long* target) {
    *target = 56;        // Sink
}

int main() {
    static int tick = 0;
    long arr[16];
    long* cursor = arr + 5;
    pad_writes(40);
    void (*sink_fp)(long*) = store_value;
    sink_fp(cursor);
    long observed = 0;
    switch (tick % 23) {
    case 4:
        observed = *cursor + 1;         // Source (rare arm)
        break;
    case 5:
        observed = *cursor + 2;         // Source (second rare arm)
        break;
    default:
        observed = *cursor + 3;         // Source (default arm)
        break;
    }
    tick = tick + 1;
    (void) observed;
}
