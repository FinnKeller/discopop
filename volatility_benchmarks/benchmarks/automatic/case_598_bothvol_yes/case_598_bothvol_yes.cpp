// ==========================================================
// Case 598 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two reader functions, the second one called only rarely
//   Sink   (write): VOLATILE - two writer functions, the second one called only rarely
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: two writer functions, the second
//   one called only rarely, gated by tick % 29 == 9. On the source
//   side: two reader functions, the second one called only rarely,
//   gated by tick % 19 == 12. The two periods are coprime, so the rare
//   write and the rare read almost never coincide and the pair of
//   endpoints wanders over four combinations across the 100
//   repetitions. The cell itself is the value member of a stack union.
//   Distance lever: 2560 padding writes, which guarantee a shadow
//   memory clear for every batch size.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare writer and the read line inside the rare reader
//   are both expected to be under-reported under sampling, so both the
//   key and the value side of the dependency record change.
// ==========================================================

union Slot { short as_value; unsigned char raw[sizeof(short)]; };

static void store_common(short* target) {
    *target = 62;                   // Sink (frequent)
}

static void store_rare(short* target) {
    *target = 69;                   // Sink (rare)
}

static int pad_area[64];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
            pad_area[i] = r ^ i;
        }
    }
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
    if (tick % 29 == 9) {
        store_rare(&slot.as_value);
    } else {
        store_common(&slot.as_value);
    }
    pad_writes(40);
    short observed = 0;
    if (tick % 19 == 12) {
        observed = load_rare(&slot.as_value);
    } else {
        observed = load_common(&slot.as_value);
    }
    tick = tick + 1;
    (void) observed;
}
