// ==========================================================
// Case 238 - Volatility split 1: no volatility
//   Source (read) : stable  - a read two call levels down
//   Sink   (write): stable  - an assignment inside a lambda
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a stack array element reached by
//   pointer arithmetic. The write is an assignment inside a lambda and
//   the read is a read two call levels down. Added noise: a second,
//   completely separate write/read pair on an unrelated variable.
//   Nothing in the program can make a different instruction take
//   either end of the dependency, so the reported dependency structure
//   cannot depend on which accesses a sampling window happens to
//   catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static unsigned int load_inner(const unsigned int* source) {
    return *source;        // Source
}

static unsigned int load_outer(const unsigned int* source) {
    return load_inner(source);
}

int main() {
    unsigned int arr[16];
    unsigned int* cursor = arr + 5;
    int companion = 0;
    companion = 271;
    int companion_seen = companion;
    (void) companion_seen;
    auto sink_lambda = [](unsigned int* target) { *target = 44; };        // Sink
    sink_lambda(cursor);
    unsigned int observed = load_outer(cursor);
    (void) observed;
}
