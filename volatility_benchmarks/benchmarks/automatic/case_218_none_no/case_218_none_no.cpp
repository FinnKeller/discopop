#include <stdlib.h>

// ==========================================================
// Case 218 - Volatility split 1: no volatility
//   Source (read) : stable  - a plain read
//   Sink   (write): stable  - an assignment two call levels down
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a stack array element whose index
//   is drawn once and shared by both ends. The write is an assignment
//   two call levels down and the read is a plain read. Added noise: a
//   dead store to an unrelated variable. Nothing in the program can
//   make a different instruction take either end of the dependency, so
//   the reported dependency structure cannot depend on which accesses
//   a sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_inner(long* target) {
    *target = 40;        // Sink
}

static void store_outer(long* target) {
    store_inner(target);
}

int main() {
    long arr[16];
    int idx = rand() % 16;
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    store_outer(&arr[idx]);
    long observed = arr[idx];        // Source
    (void) observed;
}
