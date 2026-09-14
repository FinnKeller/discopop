#include <stdlib.h>

// ==========================================================
// Case 239 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a reader function
//   Sink   (write): stable  - an assignment two call levels down
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a heap cell allocated and released
//   per repetition. The write is an assignment two call levels down
//   and the read is a read inside a reader function. Added noise: a
//   random branch that only ever touches an unrelated scratch
//   variable. Nothing in the program can make a different instruction
//   take either end of the dependency, so the reported dependency
//   structure cannot depend on which accesses a sampling window
//   happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_inner(long* target) {
    *target = 37;        // Sink
}

static void store_outer(long* target) {
    store_inner(target);
}

static long load_value(const long* source) {
    return *source;        // Source
}

int main() {
    long* cell = new long(0);
    int scratch = 0;
    if (rand() % 2 == 0) { scratch = 1; } else { scratch = 2; }
    (void) scratch;
    store_outer(cell);
    long observed = load_value(cell);
    (void) observed;
    delete cell;
}
