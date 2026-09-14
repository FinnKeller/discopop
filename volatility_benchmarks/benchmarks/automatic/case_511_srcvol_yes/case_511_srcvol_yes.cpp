#include <stdlib.h>

// ==========================================================
// Case 511 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a two slot function pointer table whose second slot is selected only rarely
//   Sink   (write): stable   - an assignment inside a function template instance
// Idea:
//   The source end offers more than one candidate read instruction: a
//   two slot function pointer table whose second slot is selected only
//   rarely. The gate tick % 23 == 11 fires on about 4 of the 100
//   repetitions, so the read line of the rare slot gets very few
//   chances to fall inside a profiling window. The write end is a
//   single instruction - an assignment inside a function template
//   instance over a stack array element whose index is drawn once and
//   shared by both ends - so only the read end of the dependency can
//   change identity. Distance lever: 256 padding reads, enough to
//   cross the smaller sampling windows. The padding is deliberately
//   placed in front of the write, so that no shadow memory clear can
//   fall between write and read and the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The read line of the
//   rare slot is expected to be the first key to vanish from the
//   sampled dependency file, which leaves the same write instruction
//   paired with a smaller set of read instructions than in the
//   baseline.
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

template <typename V>
static void store_generic(V* target, V value) {
    *target = value;        // Sink
}

static int load_common(const int* source) {
    return *source + 1;             // Source (frequent)
}

static int load_rare(const int* source) {
    return *source + 2;             // Source (rare)
}

int main() {
    static int tick = 0;
    int arr[16];
    int idx = rand() % 16;
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    store_generic<int>(&arr[idx], 32);
    int (*src_table[2])(const int*) = { load_common, load_rare };
    int src_slot = (tick % 23 == 11) ? 1 : 0;
    int observed = src_table[src_slot](&arr[idx]);
    tick = tick + 1;
    (void) observed;
}
