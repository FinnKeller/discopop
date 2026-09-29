#include <stdlib.h>

// ==========================================================
// Case 275 - Volatility split 1: no volatility
//   Source (read) : stable  - a read two call levels down
//   Sink   (write): stable  - an assignment through one of two pointers that denote the same object
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over one element of a stack array. The
//   write is an assignment through one of two pointers that denote the
//   same object and the read is a read two call levels down. Added
//   noise: a dead store to an unrelated variable. Nothing in the
//   program can make a different instruction take either end of the
//   dependency, so the reported dependency structure cannot depend on
//   which accesses a sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static char load_inner(const char* source) {
    return *source;        // Source
}

static char load_outer(const char* source) {
    return load_inner(source);
}

int main() {
    char arr[16];
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    char* alias_a = &arr[7];
    char* alias_b = &arr[7];
    char* chosen = (rand() % 2 == 0) ? alias_a : alias_b;
    *chosen = 47;        // Sink
    char observed = load_outer(&arr[7]);
    (void) observed;
}
