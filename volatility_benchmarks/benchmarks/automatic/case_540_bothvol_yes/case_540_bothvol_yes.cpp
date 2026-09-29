#include <stdlib.h>

// ==========================================================
// Case 540 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a switch over the tick counter with two rare arms and one default arm
//   Sink   (write): VOLATILE - two lambdas, the second one invoked only rarely
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: two lambdas, the second one invoked
//   only rarely, gated by tick % 41 == 23. On the source side: a
//   switch over the tick counter with two rare arms and one default
//   arm, gated by tick % 23 == 4. The two periods are coprime, so the
//   rare write and the rare read almost never coincide and the pair of
//   endpoints wanders over four combinations across the 100
//   repetitions. The cell itself is a stack array element whose index
//   is drawn once and shared by both ends. Distance lever: 2560
//   padding reads, which shift the window phase from repetition to
//   repetition.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare lambda and the two rare arm read lines are both
//   expected to be under-reported under sampling, so both the key and
//   the value side of the dependency record change.
// ==========================================================

static int pad_area[64];

static int pad_reads(int rounds) {
    int sum = 0;
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
            sum += pad_area[i];
        }
    }
    return sum;
}

int main() {
    static int tick = 0;
    unsigned int arr[16];
    int idx = rand() % 16;
    auto store_common = [](unsigned int* target) { *target = 78; };   // Sink (frequent)
    auto store_rare = [](unsigned int* target) { *target = 85; };   // Sink (rare)
    if (tick % 41 == 23) {
        store_rare(&arr[idx]);
    } else {
        store_common(&arr[idx]);
    }
    int pad_noise = pad_reads(40);
    (void) pad_noise;
    unsigned int observed = 0;
    switch (tick % 23) {
    case 4:
        observed = arr[idx] + 1;         // Source (rare arm)
        break;
    case 5:
        observed = arr[idx] + 2;         // Source (second rare arm)
        break;
    default:
        observed = arr[idx] + 3;         // Source (default arm)
        break;
    }
    tick = tick + 1;
    (void) observed;
}
