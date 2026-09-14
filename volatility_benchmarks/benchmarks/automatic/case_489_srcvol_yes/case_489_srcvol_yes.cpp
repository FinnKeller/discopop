// ==========================================================
// Case 489 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - two reader functions, the second one called only rarely
//   Sink   (write): stable   - a plain assignment
// Idea:
//   The source end offers more than one candidate read instruction:
//   two reader functions, the second one called only rarely. The gate
//   tick % 37 == 29 fires on about 2 of the 100 repetitions, so the
//   read line inside the rare reader gets very few chances to fall
//   inside a profiling window. The write end is a single instruction -
//   a plain assignment over a stack array element reached by pointer
//   arithmetic - so only the read end of the dependency can change
//   identity. Distance lever: 2560 padding writes, which guarantee a
//   shadow memory clear for every batch size. The padding is
//   deliberately placed in front of the write, so that no shadow
//   memory clear can fall between write and read and the sink end
//   stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The read line inside
//   the rare reader is expected to be the first key to vanish from the
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

static long load_common(const long* source) {
    return *source + 1;             // Source (frequent)
}

static long load_rare(const long* source) {
    return *source + 2;             // Source (rare)
}

int main() {
    static int tick = 0;
    long arr[16];
    long* cursor = arr + 5;
    pad_writes(40);
    *cursor = 41;        // Sink
    long observed = 0;
    if (tick % 37 == 29) {
        observed = load_rare(cursor);
    } else {
        observed = load_common(cursor);
    }
    tick = tick + 1;
    (void) observed;
}
