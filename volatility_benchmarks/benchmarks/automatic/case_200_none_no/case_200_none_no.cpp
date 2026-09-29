#include <stdlib.h>

// ==========================================================
// Case 200 - Volatility split 1: no volatility
//   Source (read) : stable  - a read reached through a function pointer with a single target
//   Sink   (write): stable  - an assignment through one of two pointers that denote the same object
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a field of a heap struct. The
//   write is an assignment through one of two pointers that denote the
//   same object and the read is a read reached through a function
//   pointer with a single target. Added noise: a dead store to an
//   unrelated variable. Nothing in the program can make a different
//   instruction take either end of the dependency, so the reported
//   dependency structure cannot depend on which accesses a sampling
//   window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

struct Box { long long guard; long long payload; };

static long long load_value(const long long* source) {
    return *source;        // Source
}

int main() {
    Box* box = new Box;
    box->guard = 0;
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    long long* alias_a = &box->payload;
    long long* alias_b = &box->payload;
    long long* chosen = (rand() % 2 == 0) ? alias_a : alias_b;
    *chosen = 49;        // Sink
    long long (*src_fp)(const long long*) = load_value;
    long long observed = src_fp(&box->payload);
    (void) observed;
}
