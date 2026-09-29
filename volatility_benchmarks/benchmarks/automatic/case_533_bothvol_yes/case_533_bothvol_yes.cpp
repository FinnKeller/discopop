// ==========================================================
// Case 533 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a switch over the tick counter with two rare arms and one default arm
//   Sink   (write): VOLATILE - a recursive writer that rarely stops one level early, at a different write line
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a recursive writer that rarely
//   stops one level early, at a different write line, gated by tick %
//   31 == 17. On the source side: a switch over the tick counter with
//   two rare arms and one default arm, gated by tick % 23 == 4. The
//   two periods are coprime, so the rare write and the rare read
//   almost never coincide and the pair of endpoints wanders over four
//   combinations across the 100 repetitions. The cell itself is one
//   element of a stack array. Distance lever: 2560 padding writes,
//   which guarantee a shadow memory clear for every batch size.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The shallow stop
//   write line and the two rare arm read lines are both expected to be
//   under-reported under sampling, so both the key and the value side
//   of the dependency record change.
// ==========================================================

static void store_descend(char* target, int depth, int shallow) {
    if (shallow != 0 && depth == 1) {
        *target = 77;               // Sink (rare shallow stop)
        return;
    }
    if (depth == 0) {
        *target = 70;               // Sink (bottom of recursion)
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
    char arr[16];
    int sink_shallow = (tick % 31 == 17) ? 1 : 0;
    store_descend(&arr[7], 3, sink_shallow);
    pad_writes(40);
    char observed = 0;
    switch (tick % 23) {
    case 4:
        observed = arr[7] + 1;         // Source (rare arm)
        break;
    case 5:
        observed = arr[7] + 2;         // Source (second rare arm)
        break;
    default:
        observed = arr[7] + 3;         // Source (default arm)
        break;
    }
    tick = tick + 1;
    (void) observed;
}
