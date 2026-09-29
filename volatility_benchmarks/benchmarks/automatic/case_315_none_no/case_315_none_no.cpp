// ==========================================================
// Case 315 - Volatility split 1: no volatility
//   Source (read) : stable  - a read two call levels down
//   Sink   (write): stable  - an assignment inside a lambda
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over the value member of a stack union.
//   The write is an assignment inside a lambda and the read is a read
//   two call levels down. Added noise: a dead store to an unrelated
//   variable. Nothing in the program can make a different instruction
//   take either end of the dependency, so the reported dependency
//   structure cannot depend on which accesses a sampling window
//   happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

union Slot { long long as_value; unsigned char raw[sizeof(long long)]; };

static long long load_inner(const long long* source) {
    return *source;        // Source
}

static long long load_outer(const long long* source) {
    return load_inner(source);
}

int main() {
    Slot slot;
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    auto sink_lambda = [](long long* target) { *target = 50; };        // Sink
    sink_lambda(&slot.as_value);
    long long observed = load_outer(&slot.as_value);
    (void) observed;
}
