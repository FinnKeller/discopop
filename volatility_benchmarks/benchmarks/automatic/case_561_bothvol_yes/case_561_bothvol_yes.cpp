// ==========================================================
// Case 561 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two aliases of the same cell, the second one read only rarely
//   Sink   (write): VOLATILE - two aliases of the same cell, the second one used only rarely
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: two aliases of the same cell, the
//   second one used only rarely, gated by tick % 19 == 5. On the
//   source side: two aliases of the same cell, the second one read
//   only rarely, gated by tick % 23 == 11. The two periods are
//   coprime, so the rare write and the rare read almost never coincide
//   and the pair of endpoints wanders over four combinations across
//   the 100 repetitions. The cell itself is a stack array element
//   reached by pointer arithmetic. No distance lever is used; rarity
//   on both ends carries the case.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   through the rare alias and the read line through the rare alias
//   are both expected to be under-reported under sampling, so both the
//   key and the value side of the dependency record change.
// ==========================================================

int main() {
    static int tick = 0;
    int arr[16];
    int* cursor = arr + 5;
    int* sink_alias_main = cursor;
    int* sink_alias_rare = cursor;
    if (tick % 19 == 5) {
        *sink_alias_rare = 27;          // Sink (rare alias)
    } else {
        *sink_alias_main = 20;          // Sink (frequent alias)
    }
    const int* src_alias_main = cursor;
    const int* src_alias_rare = cursor;
    int observed = 0;
    if (tick % 23 == 11) {
        observed = *src_alias_rare;    // Source (rare alias)
    } else {
        observed = *src_alias_main;    // Source (frequent alias)
    }
    tick = tick + 1;
    (void) observed;
}
