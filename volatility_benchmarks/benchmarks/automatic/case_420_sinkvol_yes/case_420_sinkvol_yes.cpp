#include <stdlib.h>

// ==========================================================
// Case 420 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read inside a function template instance
//   Sink   (write): VOLATILE - a two slot function pointer table whose second slot is selected only rarely
// Idea:
//   The sink end offers more than one candidate write instruction: a
//   two slot function pointer table whose second slot is selected only
//   rarely. The gate tick % 19 == 12 fires on about 5 of the 100
//   repetitions, so the write line of the rare slot gets very few
//   chances to fall inside a profiling window. The read end is a
//   single instruction - a read inside a function template instance
//   over a stack array element whose index is drawn once and shared by
//   both ends - so only the write end of the dependency can change
//   identity. Distance lever: 256 padding reads, enough to cross the
//   smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line of
//   the rare slot is expected to be the first edge to disappear from
//   the sampled dependency set, which leaves the same read instruction
//   paired with a smaller set of write instructions than in the
//   baseline.
// ==========================================================

static void store_common(long* target) {
    *target = 36;                   // Sink (frequent)
}

static void store_rare(long* target) {
    *target = 43;                   // Sink (rare)
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

template <typename V>
static V load_generic(const V* source) {
    return *source;        // Source
}

int main() {
    static int tick = 0;
    long arr[16];
    int idx = rand() % 16;
    void (*sink_table[2])(long*) = { store_common, store_rare };
    int sink_slot = (tick % 19 == 12) ? 1 : 0;
    sink_table[sink_slot](&arr[idx]);
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    long observed = load_generic<long>(&arr[idx]);
    tick = tick + 1;
    (void) observed;
}
