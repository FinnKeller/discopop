#include <stdlib.h>

// ==========================================================
// Case 244 - Volatility split 1: no volatility
//   Source (read) : stable  - a plain read
//   Sink   (write): stable  - an assignment inside a lambda
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a malloc'ed cell released per
//   repetition. The write is an assignment inside a lambda and the
//   read is a plain read.  Nothing in the program can make a different
//   instruction take either end of the dependency, so the reported
//   dependency structure cannot depend on which accesses a sampling
//   window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

int main() {
    long* cell = (long*) malloc(sizeof(long));
    *cell = 0;
    auto sink_lambda = [](long* target) { *target = 35; };        // Sink
    sink_lambda(cell);
    long observed = *cell;        // Source
    (void) observed;
    free(cell);
}
