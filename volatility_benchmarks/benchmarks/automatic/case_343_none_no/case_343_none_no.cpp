// ==========================================================
// Case 343 - Volatility split 1: no volatility
//   Source (read) : stable  - a read reached through a function pointer with a single target
//   Sink   (write): stable  - an assignment inside a lambda
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a function local static scalar.
//   The write is an assignment inside a lambda and the read is a read
//   reached through a function pointer with a single target. Added
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

static int load_value(const int* source) {
    return *source;        // Source
}

int main() {
    static int cell;
    cell = 0;
    int companion = 0;
    companion = 271;
    int companion_seen = companion;
    (void) companion_seen;
    auto sink_lambda = [](int* target) { *target = 36; };        // Sink
    sink_lambda(&cell);
    int (*src_fp)(const int*) = load_value;
    int observed = src_fp(&cell);
    (void) observed;
}
