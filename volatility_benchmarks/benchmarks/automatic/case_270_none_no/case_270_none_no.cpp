#include <stdlib.h>

// ==========================================================
// Case 270 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a lambda
//   Sink   (write): stable  - an assignment through one of two pointers that denote the same object
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a stack array element whose index
//   is drawn once and shared by both ends. The write is an assignment
//   through one of two pointers that denote the same object and the
//   read is a read inside a lambda. Added noise: a dead store to an
//   unrelated variable. Nothing in the program can make a different
//   instruction take either end of the dependency, so the reported
//   dependency structure cannot depend on which accesses a sampling
//   window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

int main() {
    long long arr[16];
    int idx = rand() % 16;
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    long long* alias_a = &arr[idx];
    long long* alias_b = &arr[idx];
    long long* chosen = (rand() % 2 == 0) ? alias_a : alias_b;
    *chosen = 49;        // Sink
    auto src_lambda = [](const long long* source) { return *source; };        // Source
    long long observed = src_lambda(&arr[idx]);
    (void) observed;
}
