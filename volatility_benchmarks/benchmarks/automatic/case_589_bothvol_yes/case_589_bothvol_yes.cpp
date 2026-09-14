// ==========================================================
// Case 589 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two loop shapes carrying two different read instructions
//   Sink   (write): VOLATILE - a two slot function pointer table whose second slot is selected only rarely
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a two slot function pointer table
//   whose second slot is selected only rarely, gated by tick % 41 ==
//   13. On the source side: two loop shapes carrying two different
//   read instructions, gated by tick % 29 == 19. The two periods are
//   coprime, so the rare write and the rare read almost never coincide
//   and the pair of endpoints wanders over four combinations across
//   the 100 repetitions. The cell itself is one element of a stack
//   array. Distance lever: 2560 padding writes, which guarantee a
//   shadow memory clear for every batch size.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line of
//   the rare slot and the read line of the rare loop shape are both
//   expected to be under-reported under sampling, so both the key and
//   the value side of the dependency record change.
// ==========================================================

static void store_common(unsigned int* target) {
    *target = 58;                   // Sink (frequent)
}

static void store_rare(unsigned int* target) {
    *target = 65;                   // Sink (rare)
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
    unsigned int arr[16];
    void (*sink_table[2])(unsigned int*) = { store_common, store_rare };
    int sink_slot = (tick % 41 == 13) ? 1 : 0;
    sink_table[sink_slot](&arr[7]);
    pad_writes(40);
    unsigned int observed = 0;
    if (tick % 29 == 19) {
        for (int i = 0; i < 16; i += 1) {
            if (i == 7) { observed += arr[7]; } // Source (rare dense loop)
        }
    } else {
        for (int i = 0; i < 16; i += 7) {
            if (i == 7) { observed += arr[7]; } // Source (frequent sparse loop)
        }
    }
    tick = tick + 1;
    (void) observed;
}
