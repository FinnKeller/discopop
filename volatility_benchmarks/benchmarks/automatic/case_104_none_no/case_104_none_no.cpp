// ==========================================================
// Case 104 - Volatility split 1: no volatility
//   Source (read) : stable  - a read two call levels down
//   Sink   (write): stable  - an assignment through a local pointer
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a heap cell allocated and released
//   per repetition. The write is an assignment through a local pointer
//   and the read is a read two call levels down. Added noise: a dead
//   store to an unrelated variable. Nothing in the program can make a
//   different instruction take either end of the dependency, so the
//   reported dependency structure cannot depend on which accesses a
//   sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static long long load_inner(const long long* source) {
    return *source;        // Source
}

static long long load_outer(const long long* source) {
    return load_inner(source);
}

int main() {
    long long* cell = new long long(0);
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    long long* sink_ptr = cell;
    *sink_ptr = 39;        // Sink
    long long observed = load_outer(cell);
    (void) observed;
    delete cell;
}
