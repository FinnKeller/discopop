#include <stdlib.h>

// ==========================================================
// Case 584 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a function pointer that is rarely retargeted to a second reader
//   Sink   (write): VOLATILE - a frequent write plus a rare patch write
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a frequent write plus a rare patch
//   write, gated by tick % 23 == 11. On the source side: a function
//   pointer that is rarely retargeted to a second reader, gated by
//   tick % 31 == 17. The two periods are coprime, so the rare write
//   and the rare read almost never coincide and the pair of endpoints
//   wanders over four combinations across the 100 repetitions. The
//   cell itself is a stack array element whose index is drawn once and
//   shared by both ends. Distance lever: 256 padding reads, enough to
//   cross the smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The patch write line
//   and the read line inside the rare target are both expected to be
//   under-reported under sampling, so both the key and the value side
//   of the dependency record change.
// ==========================================================

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

static long long load_common(const long long* source) {
    return *source + 1;             // Source (frequent)
}

static long long load_rare(const long long* source) {
    return *source + 2;             // Source (rare)
}

int main() {
    static int tick = 0;
    long long arr[16];
    int idx = rand() % 16;
    arr[idx] = 50;                       // Sink (frequent)
    if (tick % 23 == 11) {
        arr[idx] = 57;                   // Sink (rare patch)
    }
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    long long (*src_fp)(const long long*) = load_common;
    if (tick % 31 == 17) {
        src_fp = load_rare;
    }
    long long observed = src_fp(&arr[idx]);
    tick = tick + 1;
    (void) observed;
}
