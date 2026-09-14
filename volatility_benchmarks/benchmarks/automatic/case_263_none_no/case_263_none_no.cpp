#include <stdlib.h>

// ==========================================================
// Case 263 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a reader function
//   Sink   (write): stable  - an assignment inside a lambda
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a function local static scalar.
//   The write is an assignment inside a lambda and the read is a read
//   inside a reader function. Added noise: a random branch that only
//   ever touches an unrelated scratch variable. Nothing in the program
//   can make a different instruction take either end of the
//   dependency, so the reported dependency structure cannot depend on
//   which accesses a sampling window happens to catch.
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
    int scratch = 0;
    if (rand() % 2 == 0) { scratch = 1; } else { scratch = 2; }
    (void) scratch;
    auto sink_lambda = [](int* target) { *target = 31; };        // Sink
    sink_lambda(&cell);
    int observed = load_value(&cell);
    (void) observed;
}
