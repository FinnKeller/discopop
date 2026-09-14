#include <stdlib.h>

// ==========================================================
// Case 368 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a lambda
//   Sink   (write): stable  - an assignment two call levels down
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a stack array element whose index
//   is drawn once and shared by both ends. The write is an assignment
//   two call levels down and the read is a read inside a lambda. Added
//   noise: a second, completely separate write/read pair on an
//   unrelated variable. Nothing in the program can make a different
//   instruction take either end of the dependency, so the reported
//   dependency structure cannot depend on which accesses a sampling
//   window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_inner(long long* target) {
    *target = 48;        // Sink
}

static void store_outer(long long* target) {
    store_inner(target);
}

int main() {
    long long arr[16];
    int idx = rand() % 16;
    int companion = 0;
    companion = 271;
    int companion_seen = companion;
    (void) companion_seen;
    store_outer(&arr[idx]);
    auto src_lambda = [](const long long* source) { return *source; };        // Source
    long long observed = src_lambda(&arr[idx]);
    (void) observed;
}
