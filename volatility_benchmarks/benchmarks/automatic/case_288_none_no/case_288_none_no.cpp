// ==========================================================
// Case 288 - Volatility split 1: no volatility
//   Source (read) : stable  - a read two call levels down
//   Sink   (write): stable  - an assignment through a reference parameter
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a function local static scalar.
//   The write is an assignment through a reference parameter and the
//   read is a read two call levels down. Added noise: a dead store to
//   an unrelated variable. Nothing in the program can make a different
//   instruction take either end of the dependency, so the reported
//   dependency structure cannot depend on which accesses a sampling
//   window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_ref(short& target) {
    target = 36;        // Sink
}

static short load_inner(const short* source) {
    return *source;        // Source
}

static short load_outer(const short* source) {
    return load_inner(source);
}

int main() {
    static short cell;
    cell = 0;
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    store_ref(cell);
    short observed = load_outer(&cell);
    (void) observed;
}
