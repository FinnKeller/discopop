// ==========================================================
// Case 453 - Volatility split 3: source volatile only
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
//   identity. Distance lever: 256 padding reads, enough to cross the
//   smaller sampling windows. The padding is deliberately placed in
//   front of the write, so that no shadow memory clear can fall
//   between write and read and the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The read line inside
//   the rare reader is expected to be the first key to vanish from the
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

static int load_common(const int* source) {
    return *source + 1;             // Source (frequent)
}

static int load_rare(const int* source) {
    return *source + 2;             // Source (rare)
}

int main() {
    static int tick = 0;
    int arr[16];
    int* cursor = arr + 5;
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    *cursor = 40;        // Sink
    int observed = 0;
    if (tick % 37 == 29) {
        observed = load_rare(cursor);
    } else {
        observed = load_common(cursor);
    }
    tick = tick + 1;
    (void) observed;
}
