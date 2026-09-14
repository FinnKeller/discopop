// ==========================================================
// Case 558 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two reader functions, the second one called only rarely
//   Sink   (write): VOLATILE - a two slot function pointer table whose second slot is selected only rarely
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a two slot function pointer table
//   whose second slot is selected only rarely, gated by tick % 37 ==
//   11. On the source side: two reader functions, the second one
//   called only rarely, gated by tick % 19 == 5. The two periods are
//   coprime, so the rare write and the rare read almost never coincide
//   and the pair of endpoints wanders over four combinations across
//   the 100 repetitions. The cell itself is the value member of a
//   stack union. Distance lever: 256 padding reads, enough to cross
//   the smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line of
//   the rare slot and the read line inside the rare reader are both
//   expected to be under-reported under sampling, so both the key and
//   the value side of the dependency record change.
// ==========================================================

union Slot { short as_value; unsigned char raw[sizeof(short)]; };

static void store_common(short* target) {
    *target = 72;                   // Sink (frequent)
}

static void store_rare(short* target) {
    *target = 79;                   // Sink (rare)
}

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

static short load_common(const short* source) {
    return *source + 1;             // Source (frequent)
}

static short load_rare(const short* source) {
    return *source + 2;             // Source (rare)
}

int main() {
    static int tick = 0;
    Slot slot;
    void (*sink_table[2])(short*) = { store_common, store_rare };
    int sink_slot = (tick % 37 == 11) ? 1 : 0;
    sink_table[sink_slot](&slot.as_value);
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    short observed = 0;
    if (tick % 19 == 5) {
        observed = load_rare(&slot.as_value);
    } else {
        observed = load_common(&slot.as_value);
    }
    tick = tick + 1;
    (void) observed;
}
