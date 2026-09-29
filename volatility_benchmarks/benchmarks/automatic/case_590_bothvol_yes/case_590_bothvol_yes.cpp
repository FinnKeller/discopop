// ==========================================================
// Case 590 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a two slot function pointer table whose second slot is selected only rarely
//   Sink   (write): VOLATILE - a frequent write plus a rare patch write
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a frequent write plus a rare patch
//   write, gated by tick % 41 == 13. On the source side: a two slot
//   function pointer table whose second slot is selected only rarely,
//   gated by tick % 19 == 5. The two periods are coprime, so the rare
//   write and the rare read almost never coincide and the pair of
//   endpoints wanders over four combinations across the 100
//   repetitions. The cell itself is the value member of a stack union.
//   Distance lever: 256 padding reads, enough to cross the smaller
//   sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The patch write line
//   and the read line of the rare slot are both expected to be under-
//   reported under sampling, so both the key and the value side of the
//   dependency record change.
// ==========================================================

union Slot { int as_value; unsigned char raw[sizeof(int)]; };

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
    Slot slot;
    slot.as_value = 54;                       // Sink (frequent)
    if (tick % 41 == 13) {
        slot.as_value = 61;                   // Sink (rare patch)
    }
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    int (*src_table[2])(const int*) = { load_common, load_rare };
    int src_slot = (tick % 19 == 5) ? 1 : 0;
    int observed = src_table[src_slot](&slot.as_value);
    tick = tick + 1;
    (void) observed;
}
