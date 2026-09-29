// ==========================================================
// Case 560 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a switch over the tick counter with two rare arms and one default arm
//   Sink   (write): VOLATILE - two writer functions, the second one called only rarely
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: two writer functions, the second
//   one called only rarely, gated by tick % 41 == 23. On the source
//   side: a switch over the tick counter with two rare arms and one
//   default arm, gated by tick % 23 == 11. The two periods are
//   coprime, so the rare write and the rare read almost never coincide
//   and the pair of endpoints wanders over four combinations across
//   the 100 repetitions. The cell itself is one element of a stack
//   array. Distance lever: 2560 padding writes, which guarantee a
//   shadow memory clear for every batch size.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare writer and the two rare arm read lines are both
//   expected to be under-reported under sampling, so both the key and
//   the value side of the dependency record change.
// ==========================================================

static void store_common(int* target) {
    *target = 45;                   // Sink (frequent)
}

static void store_rare(int* target) {
    *target = 52;                   // Sink (rare)
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
    int arr[16];
    if (tick % 41 == 23) {
        store_rare(&arr[7]);
    } else {
        store_common(&arr[7]);
    }
    pad_writes(40);
    int observed = 0;
    switch (tick % 23) {
    case 11:
        observed = arr[7] + 1;         // Source (rare arm)
        break;
    case 12:
        observed = arr[7] + 2;         // Source (second rare arm)
        break;
    default:
        observed = arr[7] + 3;         // Source (default arm)
        break;
    }
    tick = tick + 1;
    (void) observed;
}
