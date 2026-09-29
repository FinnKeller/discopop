#include <stdlib.h>

// ==========================================================
// Case 556 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two read instructions in the arms of a rare/frequent branch
//   Sink   (write): VOLATILE - two writer functions, the second one called only rarely
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: two writer functions, the second
//   one called only rarely, gated by tick % 31 == 17. On the source
//   side: two read instructions in the arms of a rare/frequent branch,
//   gated by tick % 23 == 11. The two periods are coprime, so the rare
//   write and the rare read almost never coincide and the pair of
//   endpoints wanders over four combinations across the 100
//   repetitions. The cell itself is a stack array element whose index
//   is drawn once and shared by both ends. Distance lever: 256 padding
//   reads, enough to cross the smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare writer and the rare arm read line are both
//   expected to be under-reported under sampling, so both the key and
//   the value side of the dependency record change.
// ==========================================================

static void store_common(long long* target) {
    *target = 58;                   // Sink (frequent)
}

static void store_rare(long long* target) {
    *target = 65;                   // Sink (rare)
}

static int pad_area[32];

static int pad_reads(int rounds) {
    int sum = 0;
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 32; ++i) {
            sum += pad_area[i];
        }
    }
    return sum;
}

int main() {
    static int tick = 0;
    long long arr[16];
    int idx = rand() % 16;
    if (tick % 31 == 17) {
        store_rare(&arr[idx]);
    } else {
        store_common(&arr[idx]);
    }
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    long long observed = 0;
    if (tick % 23 == 11) {
        observed = arr[idx] + 1;         // Source (rare arm)
    } else {
        observed = arr[idx] + 2;         // Source (frequent arm)
    }
    tick = tick + 1;
    (void) observed;
}
