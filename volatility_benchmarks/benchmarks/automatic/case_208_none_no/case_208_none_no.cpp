// ==========================================================
// Case 208 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a lambda
//   Sink   (write): stable  - a plain assignment
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a stack array element reached by
//   pointer arithmetic. The write is a plain assignment and the read
//   is a read inside a lambda. Added noise: a dead store to an
//   unrelated variable. Nothing in the program can make a different
//   instruction take either end of the dependency, so the reported
//   dependency structure cannot depend on which accesses a sampling
//   window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

int main() {
    unsigned int arr[16];
    unsigned int* cursor = arr + 5;
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    *cursor = 33;        // Sink
    auto src_lambda = [](const unsigned int* source) { return *source; };        // Source
    unsigned int observed = src_lambda(cursor);
    (void) observed;
}
