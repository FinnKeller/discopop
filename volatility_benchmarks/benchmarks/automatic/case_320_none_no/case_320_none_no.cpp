// ==========================================================
// Case 320 - Volatility split 1: no volatility
//   Source (read) : stable  - a read two call levels down
//   Sink   (write): stable  - an assignment inside a function template instance
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a plain stack scalar. The write is
//   an assignment inside a function template instance and the read is
//   a read two call levels down. Added noise: a second, completely
//   separate write/read pair on an unrelated variable. Nothing in the
//   program can make a different instruction take either end of the
//   dependency, so the reported dependency structure cannot depend on
//   which accesses a sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

template <typename V>
static void store_generic(V* target, V value) {
    *target = value;        // Sink
}

static int load_inner(const int* source) {
    return *source;        // Source
}

static int load_outer(const int* source) {
    return load_inner(source);
}

int main() {
    int cell = 0;
    int companion = 0;
    companion = 271;
    int companion_seen = companion;
    (void) companion_seen;
    store_generic<int>(&cell, 39);
    int observed = load_outer(&cell);
    (void) observed;
}
