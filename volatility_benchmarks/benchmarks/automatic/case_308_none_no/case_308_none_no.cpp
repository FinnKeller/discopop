// ==========================================================
// Case 308 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a lambda
//   Sink   (write): stable  - an assignment inside a writer function
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a stack array element reached by
//   pointer arithmetic. The write is an assignment inside a writer
//   function and the read is a read inside a lambda.  Nothing in the
//   program can make a different instruction take either end of the
//   dependency, so the reported dependency structure cannot depend on
//   which accesses a sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_value(char* target) {
    *target = 36;        // Sink
}

int main() {
    char arr[16];
    char* cursor = arr + 5;
    store_value(cursor);
    auto src_lambda = [](const char* source) { return *source; };        // Source
    char observed = src_lambda(cursor);
    (void) observed;
}
