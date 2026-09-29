#include <stdlib.h>

// ==========================================================
// Case 373 - Volatility split 1: no volatility
//   Source (read) : stable  - a read reached through a function pointer with a single target
//   Sink   (write): stable  - an assignment through a three hop pointer chain
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a plain stack scalar. The write is
//   an assignment through a three hop pointer chain and the read is a
//   read reached through a function pointer with a single target.
//   Added noise: a random branch that only ever touches an unrelated
//   scratch variable. Nothing in the program can make a different
//   instruction take either end of the dependency, so the reported
//   dependency structure cannot depend on which accesses a sampling
//   window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static long load_value(const long* source) {
    return *source;        // Source
}

int main() {
    long cell = 0;
    int scratch = 0;
    if (rand() % 2 == 0) { scratch = 1; } else { scratch = 2; }
    (void) scratch;
    long* hop_a = &cell;
    long* hop_b = hop_a;
    long* hop_c = hop_b;
    *hop_c = 29;        // Sink
    long (*src_fp)(const long*) = load_value;
    long observed = src_fp(&cell);
    (void) observed;
}
