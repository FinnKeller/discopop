// ==========================================================
// Case 333 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a reader function
//   Sink   (write): stable  - an assignment inside a lambda
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a stack array element reached by
//   pointer arithmetic. The write is an assignment inside a lambda and
//   the read is a read inside a reader function. Added noise: a dead
//   store to an unrelated variable. Nothing in the program can make a
//   different instruction take either end of the dependency, so the
//   reported dependency structure cannot depend on which accesses a
//   sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static long long load_value(const long long* source) {
    return *source;        // Source
}

int main() {
    long long arr[16];
    long long* cursor = arr + 5;
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    auto sink_lambda = [](long long* target) { *target = 39; };        // Sink
    sink_lambda(cursor);
    long long observed = load_value(cursor);
    (void) observed;
}
