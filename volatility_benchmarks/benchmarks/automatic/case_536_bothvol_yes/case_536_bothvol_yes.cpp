// ==========================================================
// Case 536 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a function pointer that is rarely retargeted to a second reader
//   Sink   (write): VOLATILE - a switch over the tick counter with two rare arms and one default arm
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a switch over the tick counter with
//   two rare arms and one default arm, gated by tick % 37 == 29. On
//   the source side: a function pointer that is rarely retargeted to a
//   second reader, gated by tick % 41 == 13. The two periods are
//   coprime, so the rare write and the rare read almost never coincide
//   and the pair of endpoints wanders over four combinations across
//   the 100 repetitions. The cell itself is a translation unit global
//   scalar. Distance lever: 256 padding writes, enough to cross the
//   smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The two rare arm
//   write lines and the read line inside the rare target are both
//   expected to be under-reported under sampling, so both the key and
//   the value side of the dependency record change.
// ==========================================================

static long g_cell;

static int pad_area[32];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 32; ++i) {
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
    g_cell = 0;
    switch (tick % 37) {
    case 29:
        g_cell = 66;                   // Sink (rare arm)
        break;
    case 30:
        g_cell = 72;                   // Sink (second rare arm)
        break;
    default:
        g_cell = 59;                   // Sink (default arm)
        break;
    }
    pad_writes(8);
    long (*src_fp)(const long*) = load_common;
    if (tick % 41 == 13) {
        src_fp = load_rare;
    }
    long observed = src_fp(&g_cell);
    tick = tick + 1;
    (void) observed;
}
