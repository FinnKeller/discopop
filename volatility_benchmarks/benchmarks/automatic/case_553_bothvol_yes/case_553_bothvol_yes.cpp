// ==========================================================
// Case 553 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two aliases of the same cell, the second one read only rarely
//   Sink   (write): VOLATILE - two lambdas, the second one invoked only rarely
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: two lambdas, the second one invoked
//   only rarely, gated by tick % 23 == 11. On the source side: two
//   aliases of the same cell, the second one read only rarely, gated
//   by tick % 31 == 7. The two periods are coprime, so the rare write
//   and the rare read almost never coincide and the pair of endpoints
//   wanders over four combinations across the 100 repetitions. The
//   cell itself is one element of a stack array. Distance lever: 2560
//   padding writes, which guarantee a shadow memory clear for every
//   batch size.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare lambda and the read line through the rare alias
//   are both expected to be under-reported under sampling, so both the
//   key and the value side of the dependency record change.
// ==========================================================

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
    auto store_common = [](char* target) { *target = 62; };   // Sink (frequent)
    auto store_rare = [](char* target) { *target = 69; };   // Sink (rare)
    if (tick % 23 == 11) {
        store_rare(&arr[7]);
    } else {
        store_common(&arr[7]);
    }
    pad_writes(40);
    const char* src_alias_main = &arr[7];
    const char* src_alias_rare = &arr[7];
    char observed = 0;
    if (tick % 31 == 7) {
        observed = *src_alias_rare;    // Source (rare alias)
    } else {
        observed = *src_alias_main;    // Source (frequent alias)
    }
    tick = tick + 1;
    (void) observed;
}
