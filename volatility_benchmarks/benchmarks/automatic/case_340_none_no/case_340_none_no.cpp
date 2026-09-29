// ==========================================================
// Case 340 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a function template instance
//   Sink   (write): stable  - an assignment inside a writer function
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a translation unit global scalar.
//   The write is an assignment inside a writer function and the read
//   is a read inside a function template instance. Added noise: a dead
//   store to an unrelated variable. Nothing in the program can make a
//   different instruction take either end of the dependency, so the
//   reported dependency structure cannot depend on which accesses a
//   sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static long long g_cell;

static void store_value(long long* target) {
    *target = 37;        // Sink
}

template <typename V>
static V load_generic(const V* source) {
    return *source;        // Source
}

int main() {
    g_cell = 0;
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    store_value(&g_cell);
    long long observed = load_generic<long long>(&g_cell);
    (void) observed;
}
