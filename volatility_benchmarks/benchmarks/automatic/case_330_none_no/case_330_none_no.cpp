// ==========================================================
// Case 330 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a function template instance
//   Sink   (write): stable  - an assignment two call levels down
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a heap cell allocated and released
//   per repetition. The write is an assignment two call levels down
//   and the read is a read inside a function template instance. Added
//   noise: a second, completely separate write/read pair on an
//   unrelated variable. Nothing in the program can make a different
//   instruction take either end of the dependency, so the reported
//   dependency structure cannot depend on which accesses a sampling
//   window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_inner(long* target) {
    *target = 43;        // Sink
}

static void store_outer(long* target) {
    store_inner(target);
}

template <typename V>
static V load_generic(const V* source) {
    return *source;        // Source
}

int main() {
    long* cell = new long(0);
    int companion = 0;
    companion = 271;
    int companion_seen = companion;
    (void) companion_seen;
    store_outer(cell);
    long observed = load_generic<long>(cell);
    (void) observed;
    delete cell;
}
