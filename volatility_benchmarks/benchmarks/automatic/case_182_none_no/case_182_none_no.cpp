#include <stdlib.h>

// ==========================================================
// Case 182 - Volatility split 1: no volatility
//   Source (read) : stable  - a plain read
//   Sink   (write): stable  - an assignment through a three hop pointer chain
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a plain stack scalar. The write is
//   an assignment through a three hop pointer chain and the read is a
//   plain read. Added noise: a random branch that only ever touches an
//   unrelated scratch variable. Nothing in the program can make a
//   different instruction take either end of the dependency, so the
//   reported dependency structure cannot depend on which accesses a
//   sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

int main() {
    short cell = 0;
    int scratch = 0;
    if (rand() % 2 == 0) { scratch = 1; } else { scratch = 2; }
    (void) scratch;
    short* hop_a = &cell;
    short* hop_b = hop_a;
    short* hop_c = hop_b;
    *hop_c = 25;        // Sink
    short observed = cell;        // Source
    (void) observed;
}
