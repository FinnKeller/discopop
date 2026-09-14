// ==========================================================
// Case 552 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a frequent read plus a rare extra read of the same cell
//   Sink   (write): VOLATILE - a two slot function pointer table whose second slot is selected only rarely
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a two slot function pointer table
//   whose second slot is selected only rarely, gated by tick % 23 ==
//   4. On the source side: a frequent read plus a rare extra read of
//   the same cell, gated by tick % 31 == 7. The two periods are
//   coprime, so the rare write and the rare read almost never coincide
//   and the pair of endpoints wanders over four combinations across
//   the 100 repetitions. The cell itself is a function local static
//   scalar. Distance lever: 2560 padding writes, which guarantee a
//   shadow memory clear for every batch size.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line of
//   the rare slot and the extra read line are both expected to be
//   under-reported under sampling, so both the key and the value side
//   of the dependency record change.
// ==========================================================

static void store_common(long* target) {
    *target = 43;                   // Sink (frequent)
}

static void store_rare(long* target) {
    *target = 50;                   // Sink (rare)
}

static int pad_area[64];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
            pad_area[i] = r ^ i;
        }
    }
}

int main() {
    static int tick = 0;
    static long cell;
    cell = 0;
    void (*sink_table[2])(long*) = { store_common, store_rare };
    int sink_slot = (tick % 23 == 4) ? 1 : 0;
    sink_table[sink_slot](&cell);
    pad_writes(40);
    long observed = cell;              // Source (frequent)
    if (tick % 31 == 7) {
        observed += cell;            // Source (rare extra read)
    }
    tick = tick + 1;
    (void) observed;
}
