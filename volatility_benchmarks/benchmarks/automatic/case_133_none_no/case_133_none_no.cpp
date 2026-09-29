// ==========================================================
// Case 133 - Volatility split 1: no volatility
//   Source (read) : stable  - a read reached through a function pointer with a single target
//   Sink   (write): stable  - a plain assignment
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a stack array element reached by
//   pointer arithmetic. The write is a plain assignment and the read
//   is a read reached through a function pointer with a single target.
//   Nothing in the program can make a different instruction take
//   either end of the dependency, so the reported dependency structure
//   cannot depend on which accesses a sampling window happens to
//   catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static long load_value(const long* source) {
    return *source;        // Source
}

int main() {
    long arr[16];
    long* cursor = arr + 5;
    *cursor = 30;        // Sink
    long (*src_fp)(const long*) = load_value;
    long observed = src_fp(cursor);
    (void) observed;
}
