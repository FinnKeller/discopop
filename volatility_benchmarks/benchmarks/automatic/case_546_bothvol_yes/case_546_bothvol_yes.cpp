// ==========================================================
// Case 546 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two aliases of the same cell, the second one read only rarely
//   Sink   (write): VOLATILE - a recursive writer that rarely stops one level early, at a different write line
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a recursive writer that rarely
//   stops one level early, at a different write line, gated by tick %
//   23 == 4. On the source side: two aliases of the same cell, the
//   second one read only rarely, gated by tick % 37 == 11. The two
//   periods are coprime, so the rare write and the rare read almost
//   never coincide and the pair of endpoints wanders over four
//   combinations across the 100 repetitions. The cell itself is the
//   value member of a stack union. Distance lever: 2560 padding
//   writes, which guarantee a shadow memory clear for every batch
//   size.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The shallow stop
//   write line and the read line through the rare alias are both
//   expected to be under-reported under sampling, so both the key and
//   the value side of the dependency record change.
// ==========================================================

union Slot { long as_value; unsigned char raw[sizeof(long)]; };

static void store_descend(long* target, int depth, int shallow) {
    if (shallow != 0 && depth == 1) {
        *target = 40;               // Sink (rare shallow stop)
        return;
    }
    if (depth == 0) {
        *target = 33;               // Sink (bottom of recursion)
        return;
    }
    store_descend(target, depth - 1, shallow);
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
    Slot slot;
    int sink_shallow = (tick % 23 == 4) ? 1 : 0;
    store_descend(&slot.as_value, 3, sink_shallow);
    pad_writes(40);
    const long* src_alias_main = &slot.as_value;
    const long* src_alias_rare = &slot.as_value;
    long observed = 0;
    if (tick % 37 == 11) {
        observed = *src_alias_rare;    // Source (rare alias)
    } else {
        observed = *src_alias_main;    // Source (frequent alias)
    }
    tick = tick + 1;
    (void) observed;
}
