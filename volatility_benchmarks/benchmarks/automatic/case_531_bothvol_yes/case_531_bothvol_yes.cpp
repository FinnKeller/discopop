// ==========================================================
// Case 531 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a frequent read plus a rare extra read of the same cell
//   Sink   (write): VOLATILE - two write instructions in the arms of a rare/frequent branch
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: two write instructions in the arms
//   of a rare/frequent branch, gated by tick % 41 == 23. On the source
//   side: a frequent read plus a rare extra read of the same cell,
//   gated by tick % 29 == 19. The two periods are coprime, so the rare
//   write and the rare read almost never coincide and the pair of
//   endpoints wanders over four combinations across the 100
//   repetitions. The cell itself is a translation unit global scalar.
//   No distance lever is used; rarity on both ends carries the case.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The rare arm write
//   line and the extra read line are both expected to be under-
//   reported under sampling, so both the key and the value side of the
//   dependency record change.
// ==========================================================

static short g_cell;

int main() {
    static int tick = 0;
    g_cell = 0;
    if (tick % 41 == 23) {
        g_cell = 38;                   // Sink (rare arm)
    } else {
        g_cell = 31;                   // Sink (frequent arm)
    }
    short observed = g_cell;              // Source (frequent)
    if (tick % 29 == 19) {
        observed += g_cell;            // Source (rare extra read)
    }
    tick = tick + 1;
    (void) observed;
}
