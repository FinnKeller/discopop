// ==========================================================
// Case 570 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two loop shapes carrying two different read instructions
//   Sink   (write): VOLATILE - a recursive writer that rarely stops one level early, at a different write line
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a recursive writer that rarely
//   stops one level early, at a different write line, gated by tick %
//   41 == 23. On the source side: two loop shapes carrying two
//   different read instructions, gated by tick % 29 == 9. The two
//   periods are coprime, so the rare write and the rare read almost
//   never coincide and the pair of endpoints wanders over four
//   combinations across the 100 repetitions. The cell itself is the
//   value member of a stack union. No distance lever is used; rarity
//   on both ends carries the case.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The shallow stop
//   write line and the read line of the rare loop shape are both
//   expected to be under-reported under sampling, so both the key and
//   the value side of the dependency record change.
// ==========================================================

union Slot { int as_value; unsigned char raw[sizeof(int)]; };

static void store_descend(int* target, int depth, int shallow) {
    if (shallow != 0 && depth == 1) {
        *target = 41;               // Sink (rare shallow stop)
        return;
    }
    if (depth == 0) {
        *target = 34;               // Sink (bottom of recursion)
        return;
    }
    store_descend(target, depth - 1, shallow);
}

int main() {
    static int tick = 0;
    Slot slot;
    int sink_shallow = (tick % 41 == 23) ? 1 : 0;
    store_descend(&slot.as_value, 3, sink_shallow);
    int observed = 0;
    if (tick % 29 == 9) {
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
