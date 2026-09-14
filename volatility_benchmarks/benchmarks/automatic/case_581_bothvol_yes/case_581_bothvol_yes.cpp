// ==========================================================
// Case 581 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two loop shapes carrying two different read instructions
//   Sink   (write): VOLATILE - a function pointer that is rarely retargeted to a second writer
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a function pointer that is rarely
//   retargeted to a second writer, gated by tick % 31 == 7. On the
//   source side: two loop shapes carrying two different read
//   instructions, gated by tick % 29 == 19. The two periods are
//   coprime, so the rare write and the rare read almost never coincide
//   and the pair of endpoints wanders over four combinations across
//   the 100 repetitions. The cell itself is a translation unit global
//   scalar. Distance lever: 2560 padding writes, which guarantee a
//   shadow memory clear for every batch size.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare target and the read line of the rare loop shape
//   are both expected to be under-reported under sampling, so both the
//   key and the value side of the dependency record change.
// ==========================================================

static unsigned int g_cell;

static void store_common(unsigned int* target) {
    *target = 50;                   // Sink (frequent)
}

static void store_rare(unsigned int* target) {
    *target = 57;                   // Sink (rare)
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
    g_cell = 0;
    void (*sink_fp)(unsigned int*) = store_common;
    if (tick % 31 == 7) {
        sink_fp = store_rare;
    }
    sink_fp(&g_cell);
    pad_writes(40);
    unsigned int observed = 0;
    if (tick % 29 == 19) {
        for (int i = 0; i < 16; i += 1) {
            if (i == 7) { observed += g_cell; } // Source (rare dense loop)
        }
    } else {
        for (int i = 0; i < 16; i += 7) {
            if (i == 7) { observed += g_cell; } // Source (frequent sparse loop)
        }
    }
    tick = tick + 1;
    (void) observed;
}
