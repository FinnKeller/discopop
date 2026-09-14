// ==========================================================
// Case 163 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a const reference parameter
//   Sink   (write): stable  - an assignment inside a lambda
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a translation unit global scalar.
//   The write is an assignment inside a lambda and the read is a read
//   through a const reference parameter. Added noise: a dead store to
//   an unrelated variable. Nothing in the program can make a different
//   instruction take either end of the dependency, so the reported
//   dependency structure cannot depend on which accesses a sampling
//   window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static unsigned int g_cell;

static unsigned int load_ref(const unsigned int& source) {
    return source;        // Source
}

int main() {
    g_cell = 0;
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    auto sink_lambda = [](unsigned int* target) { *target = 37; };        // Sink
    sink_lambda(&g_cell);
    unsigned int observed = load_ref(g_cell);
    (void) observed;
}
