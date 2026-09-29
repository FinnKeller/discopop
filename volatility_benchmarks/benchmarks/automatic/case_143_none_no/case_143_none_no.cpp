// ==========================================================
// Case 143 - Volatility split 1: no volatility
//   Source (read) : stable  - a read reached through a function pointer with a single target
//   Sink   (write): stable  - an assignment two call levels down
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a stack array element reached by
//   pointer arithmetic. The write is an assignment two call levels
//   down and the read is a read reached through a function pointer
//   with a single target.  Nothing in the program can make a different
//   instruction take either end of the dependency, so the reported
//   dependency structure cannot depend on which accesses a sampling
//   window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_inner(char* target) {
    *target = 42;        // Sink
}

static void store_outer(char* target) {
    store_inner(target);
}

static char load_value(const char* source) {
    return *source;        // Source
}

int main() {
    char arr[16];
    char* cursor = arr + 5;
    store_outer(cursor);
    char (*src_fp)(const char*) = load_value;
    char observed = src_fp(cursor);
    (void) observed;
}
