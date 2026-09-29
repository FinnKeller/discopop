// ==========================================================
// Case 580 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a switch over the tick counter with two rare arms and one default arm
//   Sink   (write): VOLATILE - a frequent write plus a rare patch write
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a frequent write plus a rare patch
//   write, gated by tick % 29 == 19. On the source side: a switch over
//   the tick counter with two rare arms and one default arm, gated by
//   tick % 23 == 4. The two periods are coprime, so the rare write and
//   the rare read almost never coincide and the pair of endpoints
//   wanders over four combinations across the 100 repetitions. The
//   cell itself is a translation unit global scalar. Distance lever:
//   2560 padding writes, which guarantee a shadow memory clear for
//   every batch size.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The patch write line
//   and the two rare arm read lines are both expected to be under-
//   reported under sampling, so both the key and the value side of the
//   dependency record change.
// ==========================================================

static char g_cell;

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
    g_cell = 32;                       // Sink (frequent)
    if (tick % 29 == 19) {
        g_cell = 39;                   // Sink (rare patch)
    }
    pad_writes(40);
    char observed = 0;
    switch (tick % 23) {
    case 4:
        observed = g_cell + 1;         // Source (rare arm)
        break;
    case 5:
        observed = g_cell + 2;         // Source (second rare arm)
        break;
    default:
        observed = g_cell + 3;         // Source (default arm)
        break;
    }
    tick = tick + 1;
    (void) observed;
}
