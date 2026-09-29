#include <stdlib.h>

// ==========================================================
// Case 392 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read inside a function template instance
//   Sink   (write): VOLATILE - two loop shapes carrying two different write instructions
// Idea:
//   The sink end offers more than one candidate write instruction: two
//   loop shapes carrying two different write instructions. The gate
//   tick % 23 == 4 fires on about 4 of the 100 repetitions, so the
//   write line of the rare loop shape gets very few chances to fall
//   inside a profiling window. The read end is a single instruction -
//   a read inside a function template instance over a stack array
//   element whose index is drawn once and shared by both ends - so
//   only the write end of the dependency can change identity. Distance
//   lever: 2560 padding writes, which guarantee a shadow memory clear
//   for every batch size.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line of
//   the rare loop shape is expected to be the first edge to disappear
//   from the sampled dependency set, which leaves the same read
//   instruction paired with a smaller set of write instructions than
//   in the baseline.
// ==========================================================

static int pad_area[64];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
            pad_area[i] = r ^ i;
        }
    }
}

template <typename V>
static V load_generic(const V* source) {
    return *source;        // Source
}

int main() {
    static int tick = 0;
    long long arr[16];
    int idx = rand() % 16;
    if (tick % 23 == 4) {
        for (int i = 0; i < 16; i += 1) {
            if (i == 7) { arr[idx] = 61; } // Sink (rare dense loop)
        }
    } else {
        for (int i = 0; i < 16; i += 7) {
            if (i == 7) { arr[idx] = 54; } // Sink (frequent sparse loop)
        }
    }
    pad_writes(40);
    long long observed = load_generic<long long>(&arr[idx]);
    tick = tick + 1;
    (void) observed;
}
