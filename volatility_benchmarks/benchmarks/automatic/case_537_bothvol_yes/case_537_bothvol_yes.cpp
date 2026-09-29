// ==========================================================
// Case 537 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two aliases of the same cell, the second one read only rarely
//   Sink   (write): VOLATILE - two loop shapes carrying two different write instructions
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: two loop shapes carrying two
//   different write instructions, gated by tick % 31 == 17. On the
//   source side: two aliases of the same cell, the second one read
//   only rarely, gated by tick % 29 == 19. The two periods are
//   coprime, so the rare write and the rare read almost never coincide
//   and the pair of endpoints wanders over four combinations across
//   the 100 repetitions. The cell itself is a stack array element
//   reached by pointer arithmetic. Distance lever: 2560 padding reads,
//   which shift the window phase from repetition to repetition.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line of
//   the rare loop shape and the read line through the rare alias are
//   both expected to be under-reported under sampling, so both the key
//   and the value side of the dependency record change.
// ==========================================================

static int pad_area[64];

static int pad_reads(int rounds) {
    int sum = 0;
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
            sum += pad_area[i];
        }
    }
    return sum;
}

int main() {
    static int tick = 0;
    short arr[16];
    short* cursor = arr + 5;
    if (tick % 31 == 17) {
        for (int i = 0; i < 16; i += 1) {
            if (i == 7) { *cursor = 32; } // Sink (rare dense loop)
        }
    } else {
        for (int i = 0; i < 16; i += 7) {
            if (i == 7) { *cursor = 25; } // Sink (frequent sparse loop)
        }
    }
    int pad_noise = pad_reads(40);
    (void) pad_noise;
    const short* src_alias_main = cursor;
    const short* src_alias_rare = cursor;
    short observed = 0;
    if (tick % 29 == 19) {
        observed = *src_alias_rare;    // Source (rare alias)
    } else {
        observed = *src_alias_main;    // Source (frequent alias)
    }
    tick = tick + 1;
    (void) observed;
}
