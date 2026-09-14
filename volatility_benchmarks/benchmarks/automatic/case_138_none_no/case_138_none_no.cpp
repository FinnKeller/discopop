// ==========================================================
// Case 138 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a const reference parameter
//   Sink   (write): stable  - an assignment reached through a function pointer with a single target
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a function local static scalar.
//   The write is an assignment reached through a function pointer with
//   a single target and the read is a read through a const reference
//   parameter.  Nothing in the program can make a different
//   instruction take either end of the dependency, so the reported
//   dependency structure cannot depend on which accesses a sampling
//   window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_value(long long* target) {
    *target = 33;        // Sink
}

static long long load_ref(const long long& source) {
    return source;        // Source
}

int main() {
    static long long cell;
    cell = 0;
    void (*sink_fp)(long long*) = store_value;
    sink_fp(&cell);
    long long observed = load_ref(cell);
    (void) observed;
}
