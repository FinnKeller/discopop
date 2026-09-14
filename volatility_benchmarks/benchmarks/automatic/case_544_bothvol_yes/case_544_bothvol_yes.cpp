// ==========================================================
// Case 544 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a two slot function pointer table whose second slot is selected only rarely
//   Sink   (write): VOLATILE - two writer functions, the second one called only rarely
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: two writer functions, the second
//   one called only rarely, gated by tick % 31 == 7. On the source
//   side: a two slot function pointer table whose second slot is
//   selected only rarely, gated by tick % 29 == 9. The two periods are
//   coprime, so the rare write and the rare read almost never coincide
//   and the pair of endpoints wanders over four combinations across
//   the 100 repetitions. The cell itself is a function local static
//   scalar. No distance lever is used; rarity on both ends carries the
//   case.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare writer and the read line of the rare slot are both
//   expected to be under-reported under sampling, so both the key and
//   the value side of the dependency record change.
// ==========================================================

static void store_common(char* target) {
    *target = 37;                   // Sink (frequent)
}

static void store_rare(char* target) {
    *target = 44;                   // Sink (rare)
}

static char load_common(const char* source) {
    return *source + 1;             // Source (frequent)
}

static char load_rare(const char* source) {
    return *source + 2;             // Source (rare)
}

int main() {
    static int tick = 0;
    static char cell;
    cell = 0;
    if (tick % 31 == 7) {
        store_rare(&cell);
    } else {
        store_common(&cell);
    }
    char (*src_table[2])(const char*) = { load_common, load_rare };
    int src_slot = (tick % 29 == 9) ? 1 : 0;
    char observed = src_table[src_slot](&cell);
    tick = tick + 1;
    (void) observed;
}
