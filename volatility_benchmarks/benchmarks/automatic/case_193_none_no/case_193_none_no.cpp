#include <stdlib.h>

// ==========================================================
// Case 193 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a local pointer
//   Sink   (write): stable  - an assignment two call levels down
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over one element of a stack array. The
//   write is an assignment two call levels down and the read is a read
//   through a local pointer. Added noise: a random branch that only
//   ever touches an unrelated scratch variable. Nothing in the program
//   can make a different instruction take either end of the
//   dependency, so the reported dependency structure cannot depend on
//   which accesses a sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_inner(unsigned int* target) {
    *target = 36;        // Sink
}

static void store_outer(unsigned int* target) {
    store_inner(target);
}

int main() {
    unsigned int arr[16];
    int scratch = 0;
    if (rand() % 2 == 0) { scratch = 1; } else { scratch = 2; }
    (void) scratch;
    store_outer(&arr[7]);
    const unsigned int* src_ptr = &arr[7];
    unsigned int observed = *src_ptr;        // Source
    (void) observed;
}
