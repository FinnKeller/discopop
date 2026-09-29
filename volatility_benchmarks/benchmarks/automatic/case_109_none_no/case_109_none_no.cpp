#include <stdlib.h>

// ==========================================================
// Case 109 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a local pointer
//   Sink   (write): stable  - an assignment two call levels down
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a malloc'ed cell released per
//   repetition. The write is an assignment two call levels down and
//   the read is a read through a local pointer. Added noise: a random
//   branch that only ever touches an unrelated scratch variable.
//   Nothing in the program can make a different instruction take
//   either end of the dependency, so the reported dependency structure
//   cannot depend on which accesses a sampling window happens to
//   catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_inner(long long* target) {
    *target = 41;        // Sink
}

static void store_outer(long long* target) {
    store_inner(target);
}

int main() {
    long long* cell = (long long*) malloc(sizeof(long long));
    *cell = 0;
    int scratch = 0;
    if (rand() % 2 == 0) { scratch = 1; } else { scratch = 2; }
    (void) scratch;
    store_outer(cell);
    const long long* src_ptr = cell;
    long long observed = *src_ptr;        // Source
    (void) observed;
    free(cell);
}
