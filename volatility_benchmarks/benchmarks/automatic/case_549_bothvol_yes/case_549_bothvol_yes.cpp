// ==========================================================
// Case 549 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a two slot function pointer table whose second slot is selected only rarely
//   Sink   (write): VOLATILE - a recursive writer that rarely stops one level early, at a different write line
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a recursive writer that rarely
//   stops one level early, at a different write line, gated by tick %
//   29 == 19. On the source side: a two slot function pointer table
//   whose second slot is selected only rarely, gated by tick % 41 ==
//   13. The two periods are coprime, so the rare write and the rare
//   read almost never coincide and the pair of endpoints wanders over
//   four combinations across the 100 repetitions. The cell itself is a
//   plain stack scalar. Distance lever: 256 padding writes, enough to
//   cross the smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The shallow stop
//   write line and the read line of the rare slot are both expected to
//   be under-reported under sampling, so both the key and the value
//   side of the dependency record change.
// ==========================================================

static void store_descend(int* target, int depth, int shallow) {
    if (shallow != 0 && depth == 1) {
        *target = 66;               // Sink (rare shallow stop)
        return;
    }
    if (depth == 0) {
        *target = 59;               // Sink (bottom of recursion)
        return;
    }
    store_descend(target, depth - 1, shallow);
}

static int pad_area[32];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 32; ++i) {
            pad_area[i] = r ^ i;
        }
    }
}

static int load_common(const int* source) {
    return *source + 1;             // Source (frequent)
}

static int load_rare(const int* source) {
    return *source + 2;             // Source (rare)
}

int main() {
    static int tick = 0;
    int cell = 0;
    int sink_shallow = (tick % 29 == 19) ? 1 : 0;
    store_descend(&cell, 3, sink_shallow);
    pad_writes(8);
    int (*src_table[2])(const int*) = { load_common, load_rare };
    int src_slot = (tick % 41 == 13) ? 1 : 0;
    int observed = src_table[src_slot](&cell);
    tick = tick + 1;
    (void) observed;
}
