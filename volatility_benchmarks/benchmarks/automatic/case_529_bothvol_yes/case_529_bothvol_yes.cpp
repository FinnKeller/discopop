// ==========================================================
// Case 529 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two aliases of the same cell, the second one read only rarely
//   Sink   (write): VOLATILE - two write instructions in the arms of a rare/frequent branch
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: two write instructions in the arms
//   of a rare/frequent branch, gated by tick % 37 == 11. On the source
//   side: two aliases of the same cell, the second one read only
//   rarely, gated by tick % 29 == 19. The two periods are coprime, so
//   the rare write and the rare read almost never coincide and the
//   pair of endpoints wanders over four combinations across the 100
//   repetitions. The cell itself is a function local static scalar.
//   Distance lever: 2560 padding reads, which shift the window phase
//   from repetition to repetition.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The rare arm write
//   line and the read line through the rare alias are both expected to
//   be under-reported under sampling, so both the key and the value
//   side of the dependency record change.
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
    static short cell;
    cell = 0;
    if (tick % 37 == 11) {
        cell = 43;                   // Sink (rare arm)
    } else {
        cell = 36;                   // Sink (frequent arm)
    }
    int pad_noise = pad_reads(40);
    (void) pad_noise;
    const short* src_alias_main = &cell;
    const short* src_alias_rare = &cell;
    short observed = 0;
    if (tick % 29 == 19) {
        observed = *src_alias_rare;    // Source (rare alias)
    } else {
        observed = *src_alias_main;    // Source (frequent alias)
    }
    tick = tick + 1;
    (void) observed;
}
