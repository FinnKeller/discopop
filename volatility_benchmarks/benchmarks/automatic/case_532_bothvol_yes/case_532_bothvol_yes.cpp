// ==========================================================
// Case 532 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two reader functions, the second one called only rarely
//   Sink   (write): VOLATILE - a frequent write plus a rare patch write
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a frequent write plus a rare patch
//   write, gated by tick % 31 == 7. On the source side: two reader
//   functions, the second one called only rarely, gated by tick % 29
//   == 9. The two periods are coprime, so the rare write and the rare
//   read almost never coincide and the pair of endpoints wanders over
//   four combinations across the 100 repetitions. The cell itself is a
//   stack array element reached by pointer arithmetic. Distance lever:
//   256 padding reads, enough to cross the smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The patch write line
//   and the read line inside the rare reader are both expected to be
//   under-reported under sampling, so both the key and the value side
//   of the dependency record change.
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

static long long load_common(const long long* source) {
    return *source + 1;             // Source (frequent)
}

static long long load_rare(const long long* source) {
    return *source + 2;             // Source (rare)
}

int main() {
    static int tick = 0;
    long long arr[16];
    long long* cursor = arr + 5;
    *cursor = 34;                       // Sink (frequent)
    if (tick % 31 == 7) {
        *cursor = 41;                   // Sink (rare patch)
    }
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    long long observed = 0;
    if (tick % 29 == 9) {
        observed = load_rare(cursor);
    } else {
        observed = load_common(cursor);
    }
    tick = tick + 1;
    (void) observed;
}
