#include <stdlib.h>

// ==========================================================
// Case 576 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two reader functions, the second one called only rarely
//   Sink   (write): VOLATILE - two lambdas, the second one invoked only rarely
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: two lambdas, the second one invoked
//   only rarely, gated by tick % 29 == 19. On the source side: two
//   reader functions, the second one called only rarely, gated by tick
//   % 23 == 11. The two periods are coprime, so the rare write and the
//   rare read almost never coincide and the pair of endpoints wanders
//   over four combinations across the 100 repetitions. The cell itself
//   is a stack array element whose index is drawn once and shared by
//   both ends. Distance lever: 256 padding writes, enough to cross the
//   smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare lambda and the read line inside the rare reader
//   are both expected to be under-reported under sampling, so both the
//   key and the value side of the dependency record change.
// ==========================================================

static int pad_area[32];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 32; ++i) {
            pad_area[i] = r ^ i;
        }
    }
}

static char load_common(const char* source) {
    return *source + 1;             // Source (frequent)
}

static char load_rare(const char* source) {
    return *source + 2;             // Source (rare)
}

int main() {
    static int tick = 0;
    char arr[16];
    int idx = rand() % 16;
    auto store_common = [](char* target) { *target = 74; };   // Sink (frequent)
    auto store_rare = [](char* target) { *target = 81; };   // Sink (rare)
    if (tick % 29 == 19) {
        store_rare(&arr[idx]);
    } else {
        store_common(&arr[idx]);
    }
    pad_writes(8);
    char observed = 0;
    if (tick % 23 == 11) {
        observed = load_rare(&arr[idx]);
    } else {
        observed = load_common(&arr[idx]);
    }
    tick = tick + 1;
    (void) observed;
}
