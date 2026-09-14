// ==========================================================
// Case 542 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two reader functions, the second one called only rarely
//   Sink   (write): VOLATILE - a function pointer that is rarely retargeted to a second writer
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a function pointer that is rarely
//   retargeted to a second writer, gated by tick % 31 == 17. On the
//   source side: two reader functions, the second one called only
//   rarely, gated by tick % 41 == 13. The two periods are coprime, so
//   the rare write and the rare read almost never coincide and the
//   pair of endpoints wanders over four combinations across the 100
//   repetitions. The cell itself is the value member of a stack union.
//   Distance lever: 256 padding writes, enough to cross the smaller
//   sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare target and the read line inside the rare reader
//   are both expected to be under-reported under sampling, so both the
//   key and the value side of the dependency record change.
// ==========================================================

union Slot { short as_value; unsigned char raw[sizeof(short)]; };

static void store_common(short* target) {
    *target = 67;                   // Sink (frequent)
}

static void store_rare(short* target) {
    *target = 74;                   // Sink (rare)
}

static int pad_area[32];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 32; ++i) {
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
    void (*sink_fp)(short*) = store_common;
    if (tick % 31 == 17) {
        sink_fp = store_rare;
    }
    sink_fp(&slot.as_value);
    pad_writes(8);
    short observed = 0;
    if (tick % 41 == 13) {
        observed = load_rare(&slot.as_value);
    } else {
        observed = load_common(&slot.as_value);
    }
    tick = tick + 1;
    (void) observed;
}
