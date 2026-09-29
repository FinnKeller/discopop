// ==========================================================
// Case 577 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two read instructions in the arms of a rare/frequent branch
//   Sink   (write): VOLATILE - a two slot function pointer table whose second slot is selected only rarely
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a two slot function pointer table
//   whose second slot is selected only rarely, gated by tick % 19 ==
//   12. On the source side: two read instructions in the arms of a
//   rare/frequent branch, gated by tick % 31 == 7. The two periods are
//   coprime, so the rare write and the rare read almost never coincide
//   and the pair of endpoints wanders over four combinations across
//   the 100 repetitions. The cell itself is a heap cell whose address
//   moves every repetition. Distance lever: 256 padding writes, enough
//   to cross the smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line of
//   the rare slot and the rare arm read line are both expected to be
//   under-reported under sampling, so both the key and the value side
//   of the dependency record change.
// ==========================================================

static void store_common(long* target) {
    *target = 59;                   // Sink (frequent)
}

static void store_rare(long* target) {
    *target = 66;                   // Sink (rare)
}

static int pad_area[32];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 32; ++i) {
            pad_area[i] = r ^ i;
        }
    }
}

int main() {
    static int tick = 0;
    long* cell = new long(0);
    void (*sink_table[2])(long*) = { store_common, store_rare };
    int sink_slot = (tick % 19 == 12) ? 1 : 0;
    sink_table[sink_slot](cell);
    pad_writes(8);
    long observed = 0;
    if (tick % 31 == 7) {
        observed = *cell + 1;         // Source (rare arm)
    } else {
        observed = *cell + 2;         // Source (frequent arm)
    }
    tick = tick + 1;
    (void) observed;
}
