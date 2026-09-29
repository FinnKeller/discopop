// ==========================================================
// Case 586 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a function pointer that is rarely retargeted to a second reader
//   Sink   (write): VOLATILE - two lambdas, the second one invoked only rarely
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: two lambdas, the second one invoked
//   only rarely, gated by tick % 31 == 7. On the source side: a
//   function pointer that is rarely retargeted to a second reader,
//   gated by tick % 23 == 11. The two periods are coprime, so the rare
//   write and the rare read almost never coincide and the pair of
//   endpoints wanders over four combinations across the 100
//   repetitions. The cell itself is the value member of a stack union.
//   No distance lever is used; rarity on both ends carries the case.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare lambda and the read line inside the rare target
//   are both expected to be under-reported under sampling, so both the
//   key and the value side of the dependency record change.
// ==========================================================

union Slot { char as_value; unsigned char raw[sizeof(char)]; };

static char load_common(const char* source) {
    return *source + 1;             // Source (frequent)
}

static char load_rare(const char* source) {
    return *source + 2;             // Source (rare)
}

int main() {
    static int tick = 0;
    Slot slot;
    auto store_common = [](char* target) { *target = 78; };   // Sink (frequent)
    auto store_rare = [](char* target) { *target = 85; };   // Sink (rare)
    if (tick % 31 == 7) {
        store_rare(&slot.as_value);
    } else {
        store_common(&slot.as_value);
    }
    char (*src_fp)(const char*) = load_common;
    if (tick % 23 == 11) {
        src_fp = load_rare;
    }
    char observed = src_fp(&slot.as_value);
    tick = tick + 1;
    (void) observed;
}
