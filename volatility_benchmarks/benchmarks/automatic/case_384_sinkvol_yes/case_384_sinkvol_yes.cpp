// ==========================================================
// Case 384 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read inside a function template instance
//   Sink   (write): VOLATILE - two writer functions, the second one called only rarely
// Idea:
//   The sink end offers more than one candidate write instruction: two
//   writer functions, the second one called only rarely. The gate tick
//   % 23 == 4 fires on about 4 of the 100 repetitions, so the write
//   line inside the rare writer gets very few chances to fall inside a
//   profiling window. The read end is a single instruction - a read
//   inside a function template instance over a stack array element
//   reached by pointer arithmetic - so only the write end of the
//   dependency can change identity. Distance lever: 2560 padding
//   writes, which guarantee a shadow memory clear for every batch
//   size.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare writer is expected to be the first edge to
//   disappear from the sampled dependency set, which leaves the same
//   read instruction paired with a smaller set of write instructions
//   than in the baseline.
// ==========================================================

static void store_common(long long* target) {
    *target = 58;                   // Sink (frequent)
}

static void store_rare(long long* target) {
    *target = 65;                   // Sink (rare)
}

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
    long long* cursor = arr + 5;
    if (tick % 23 == 4) {
        store_rare(cursor);
    } else {
        store_common(cursor);
    }
    pad_writes(40);
    long long observed = load_generic<long long>(cursor);
    tick = tick + 1;
    (void) observed;
}
