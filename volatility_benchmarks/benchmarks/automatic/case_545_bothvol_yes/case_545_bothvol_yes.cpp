// ==========================================================
// Case 545 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a switch over the tick counter with two rare arms and one default arm
//   Sink   (write): VOLATILE - a function pointer that is rarely retargeted to a second writer
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a function pointer that is rarely
//   retargeted to a second writer, gated by tick % 19 == 5. On the
//   source side: a switch over the tick counter with two rare arms and
//   one default arm, gated by tick % 29 == 9. The two periods are
//   coprime, so the rare write and the rare read almost never coincide
//   and the pair of endpoints wanders over four combinations across
//   the 100 repetitions. The cell itself is a heap cell whose address
//   moves every repetition. No distance lever is used; rarity on both
//   ends carries the case.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare target and the two rare arm read lines are both
//   expected to be under-reported under sampling, so both the key and
//   the value side of the dependency record change.
// ==========================================================

static void store_common(unsigned int* target) {
    *target = 59;                   // Sink (frequent)
}

static void store_rare(unsigned int* target) {
    *target = 66;                   // Sink (rare)
}

int main() {
    static int tick = 0;
    unsigned int* cell = new unsigned int(0);
    void (*sink_fp)(unsigned int*) = store_common;
    if (tick % 19 == 5) {
        sink_fp = store_rare;
    }
    sink_fp(cell);
    unsigned int observed = 0;
    switch (tick % 29) {
    case 9:
        observed = *cell + 1;         // Source (rare arm)
        break;
    case 10:
        observed = *cell + 2;         // Source (second rare arm)
        break;
    default:
        observed = *cell + 3;         // Source (default arm)
        break;
    }
    tick = tick + 1;
    (void) observed;
}
