// ==========================================================
// Case 380 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read inside a function template instance
//   Sink   (write): VOLATILE - two lambdas, the second one invoked only rarely
// Idea:
//   The sink end offers more than one candidate write instruction: two
//   lambdas, the second one invoked only rarely. The gate tick % 37 ==
//   11 fires on about 2 of the 100 repetitions, so the write line
//   inside the rare lambda gets very few chances to fall inside a
//   profiling window. The read end is a single instruction - a read
//   inside a function template instance over the value member of a
//   stack union - so only the write end of the dependency can change
//   identity. Distance lever: 256 padding reads, enough to cross the
//   smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare lambda is expected to be the first edge to
//   disappear from the sampled dependency set, which leaves the same
//   read instruction paired with a smaller set of write instructions
//   than in the baseline.
// ==========================================================

union Slot { long long as_value; unsigned char raw[sizeof(long long)]; };

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
    Slot slot;
    auto store_common = [](long long* target) { *target = 49; };   // Sink (frequent)
    auto store_rare = [](long long* target) { *target = 56; };   // Sink (rare)
    if (tick % 37 == 11) {
        store_rare(&slot.as_value);
    } else {
        store_common(&slot.as_value);
    }
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    long long observed = load_generic<long long>(&slot.as_value);
    tick = tick + 1;
    (void) observed;
}
