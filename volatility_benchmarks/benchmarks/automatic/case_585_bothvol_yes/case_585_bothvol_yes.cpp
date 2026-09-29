// ==========================================================
// Case 585 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two aliases of the same cell, the second one read only rarely
//   Sink   (write): VOLATILE - two aliases of the same cell, the second one used only rarely
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: two aliases of the same cell, the
//   second one used only rarely, gated by tick % 31 == 17. On the
//   source side: two aliases of the same cell, the second one read
//   only rarely, gated by tick % 37 == 29. The two periods are
//   coprime, so the rare write and the rare read almost never coincide
//   and the pair of endpoints wanders over four combinations across
//   the 100 repetitions. The cell itself is a translation unit global
//   scalar. Distance lever: 256 padding reads, enough to cross the
//   smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   through the rare alias and the read line through the rare alias
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

int main() {
    static int tick = 0;
    g_cell = 0;
    char* sink_alias_main = &g_cell;
    char* sink_alias_rare = &g_cell;
    if (tick % 31 == 17) {
        *sink_alias_rare = 81;          // Sink (rare alias)
    } else {
        *sink_alias_main = 74;          // Sink (frequent alias)
    }
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    const char* src_alias_main = &g_cell;
    const char* src_alias_rare = &g_cell;
    char observed = 0;
    if (tick % 37 == 29) {
        observed = *src_alias_rare;    // Source (rare alias)
    } else {
        observed = *src_alias_main;    // Source (frequent alias)
    }
    tick = tick + 1;
    (void) observed;
}
