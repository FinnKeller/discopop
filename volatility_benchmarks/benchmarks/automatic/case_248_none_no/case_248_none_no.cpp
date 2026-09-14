// ==========================================================
// Case 248 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a const reference parameter
//   Sink   (write): stable  - an assignment inside a writer function
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a stack array element reached by
//   pointer arithmetic. The write is an assignment inside a writer
//   function and the read is a read through a const reference
//   parameter. Added noise: a dead store to an unrelated variable.
//   Nothing in the program can make a different instruction take
//   either end of the dependency, so the reported dependency structure
//   cannot depend on which accesses a sampling window happens to
//   catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_value(long long* target) {
    *target = 36;        // Sink
}

static long long load_ref(const long long& source) {
    return source;        // Source
}

int main() {
    long long arr[16];
    long long* cursor = arr + 5;
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    store_value(cursor);
    long long observed = load_ref(*cursor);
    (void) observed;
}
