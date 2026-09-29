// ==========================================================
// Case 592 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a frequent read plus a rare extra read of the same cell
//   Sink   (write): VOLATILE - a function pointer that is rarely retargeted to a second writer
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a function pointer that is rarely
//   retargeted to a second writer, gated by tick % 23 == 4. On the
//   source side: a frequent read plus a rare extra read of the same
//   cell, gated by tick % 41 == 23. The two periods are coprime, so
//   the rare write and the rare read almost never coincide and the
//   pair of endpoints wanders over four combinations across the 100
//   repetitions. The cell itself is one element of a stack array. No
//   distance lever is used; rarity on both ends carries the case.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare target and the extra read line are both expected
//   to be under-reported under sampling, so both the key and the value
//   side of the dependency record change.
// ==========================================================

static void store_common(int* target) {
    *target = 44;                   // Sink (frequent)
}

static void store_rare(int* target) {
    *target = 51;                   // Sink (rare)
}

int main() {
    static int tick = 0;
    int arr[16];
    void (*sink_fp)(int*) = store_common;
    if (tick % 23 == 4) {
        sink_fp = store_rare;
    }
    sink_fp(&arr[7]);
    int observed = arr[7];              // Source (frequent)
    if (tick % 41 == 23) {
        observed += arr[7];            // Source (rare extra read)
    }
    tick = tick + 1;
    (void) observed;
}
