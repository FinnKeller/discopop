// ==========================================================
// Case 557 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two aliases of the same cell, the second one read only rarely
//   Sink   (write): VOLATILE - a function pointer that is rarely retargeted to a second writer
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a function pointer that is rarely
//   retargeted to a second writer, gated by tick % 37 == 11. On the
//   source side: two aliases of the same cell, the second one read
//   only rarely, gated by tick % 41 == 23. The two periods are
//   coprime, so the rare write and the rare read almost never coincide
//   and the pair of endpoints wanders over four combinations across
//   the 100 repetitions. The cell itself is a function local static
//   scalar. Distance lever: 2560 padding reads, which shift the window
//   phase from repetition to repetition.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare target and the read line through the rare alias
//   are both expected to be under-reported under sampling, so both the
//   key and the value side of the dependency record change.
// ==========================================================

static void store_common(int* target) {
    *target = 46;                   // Sink (frequent)
}

static void store_rare(int* target) {
    *target = 53;                   // Sink (rare)
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

int main() {
    static int tick = 0;
    static int cell;
    cell = 0;
    void (*sink_fp)(int*) = store_common;
    if (tick % 37 == 11) {
        sink_fp = store_rare;
    }
    sink_fp(&cell);
    int pad_noise = pad_reads(40);
    (void) pad_noise;
    const int* src_alias_main = &cell;
    const int* src_alias_rare = &cell;
    int observed = 0;
    if (tick % 41 == 23) {
        observed = *src_alias_rare;    // Source (rare alias)
    } else {
        observed = *src_alias_main;    // Source (frequent alias)
    }
    tick = tick + 1;
    (void) observed;
}
