// ==========================================================
// Case 574 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two loop shapes carrying two different read instructions
//   Sink   (write): VOLATILE - a function pointer that is rarely retargeted to a second writer
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a function pointer that is rarely
//   retargeted to a second writer, gated by tick % 37 == 11. On the
//   source side: two loop shapes carrying two different read
//   instructions, gated by tick % 41 == 23. The two periods are
//   coprime, so the rare write and the rare read almost never coincide
//   and the pair of endpoints wanders over four combinations across
//   the 100 repetitions. The cell itself is the value member of a
//   stack union. No distance lever is used; rarity on both ends
//   carries the case.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare target and the read line of the rare loop shape
//   are both expected to be under-reported under sampling, so both the
//   key and the value side of the dependency record change.
// ==========================================================

union Slot { unsigned int as_value; unsigned char raw[sizeof(unsigned int)]; };

static void store_common(unsigned int* target) {
    *target = 74;                   // Sink (frequent)
}

static void store_rare(unsigned int* target) {
    *target = 81;                   // Sink (rare)
}

int main() {
    static int tick = 0;
    Slot slot;
    void (*sink_fp)(unsigned int*) = store_common;
    if (tick % 37 == 11) {
        sink_fp = store_rare;
    }
    sink_fp(&slot.as_value);
    unsigned int observed = 0;
    if (tick % 41 == 23) {
        for (int i = 0; i < 16; i += 1) {
            if (i == 7) { observed += slot.as_value; } // Source (rare dense loop)
        }
    } else {
        for (int i = 0; i < 16; i += 7) {
            if (i == 7) { observed += slot.as_value; } // Source (frequent sparse loop)
        }
    }
    tick = tick + 1;
    (void) observed;
}
