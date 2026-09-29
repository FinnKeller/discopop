// ==========================================================
// Case 564 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a two slot function pointer table whose second slot is selected only rarely
//   Sink   (write): VOLATILE - a two slot function pointer table whose second slot is selected only rarely
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a two slot function pointer table
//   whose second slot is selected only rarely, gated by tick % 37 ==
//   29. On the source side: a two slot function pointer table whose
//   second slot is selected only rarely, gated by tick % 41 == 23. The
//   two periods are coprime, so the rare write and the rare read
//   almost never coincide and the pair of endpoints wanders over four
//   combinations across the 100 repetitions. The cell itself is a
//   function local static scalar. Distance lever: 2560 padding reads,
//   which shift the window phase from repetition to repetition.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line of
//   the rare slot and the read line of the rare slot are both expected
//   to be under-reported under sampling, so both the key and the value
//   side of the dependency record change.
// ==========================================================

static void store_common(long long* target) {
    *target = 47;                   // Sink (frequent)
}

static void store_rare(long long* target) {
    *target = 54;                   // Sink (rare)
}

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

static long long load_common(const long long* source) {
    return *source + 1;             // Source (frequent)
}

static long long load_rare(const long long* source) {
    return *source + 2;             // Source (rare)
}

int main() {
    static int tick = 0;
    static long long cell;
    cell = 0;
    void (*sink_table[2])(long long*) = { store_common, store_rare };
    int sink_slot = (tick % 37 == 29) ? 1 : 0;
    sink_table[sink_slot](&cell);
    int pad_noise = pad_reads(40);
    (void) pad_noise;
    long long (*src_table[2])(const long long*) = { load_common, load_rare };
    int src_slot = (tick % 41 == 23) ? 1 : 0;
    long long observed = src_table[src_slot](&cell);
    tick = tick + 1;
    (void) observed;
}
