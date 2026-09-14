// ==========================================================
// Case 600 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a function pointer that is rarely retargeted to a second reader
//   Sink   (write): VOLATILE - two lambdas, the second one invoked only rarely
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: two lambdas, the second one invoked
//   only rarely, gated by tick % 19 == 5. On the source side: a
//   function pointer that is rarely retargeted to a second reader,
//   gated by tick % 37 == 11. The two periods are coprime, so the rare
//   write and the rare read almost never coincide and the pair of
//   endpoints wanders over four combinations across the 100
//   repetitions. The cell itself is a translation unit global scalar.
//   Distance lever: 256 padding reads, enough to cross the smaller
//   sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare lambda and the read line inside the rare target
//   are both expected to be under-reported under sampling, so both the
//   key and the value side of the dependency record change.
// ==========================================================

static char g_cell;

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

static char load_common(const char* source) {
    return *source + 1;             // Source (frequent)
}

static char load_rare(const char* source) {
    return *source + 2;             // Source (rare)
}

int main() {
    static int tick = 0;
    g_cell = 0;
    auto store_common = [](char* target) { *target = 54; };   // Sink (frequent)
    auto store_rare = [](char* target) { *target = 61; };   // Sink (rare)
    if (tick % 19 == 5) {
        store_rare(&g_cell);
    } else {
        store_common(&g_cell);
    }
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    char (*src_fp)(const char*) = load_common;
    if (tick % 37 == 11) {
        src_fp = load_rare;
    }
    char observed = src_fp(&g_cell);
    tick = tick + 1;
    (void) observed;
}
