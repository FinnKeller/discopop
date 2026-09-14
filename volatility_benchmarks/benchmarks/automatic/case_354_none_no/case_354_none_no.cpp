#include <stdlib.h>

// ==========================================================
// Case 354 - Volatility split 1: no volatility
//   Source (read) : stable  - a read two call levels down
//   Sink   (write): stable  - an assignment reached through a randomly indexed table whose slots are all the same function
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a field of a heap struct. The
//   write is an assignment reached through a randomly indexed table
//   whose slots are all the same function and the read is a read two
//   call levels down. Added noise: a dead store to an unrelated
//   variable. Nothing in the program can make a different instruction
//   take either end of the dependency, so the reported dependency
//   structure cannot depend on which accesses a sampling window
//   happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

struct Box { long long guard; long long payload; };

static void store_value(long long* target) {
    *target = 47;        // Sink
}

static long long load_inner(const long long* source) {
    return *source;        // Source
}

static long long load_outer(const long long* source) {
    return load_inner(source);
}

int main() {
    Box* box = new Box;
    box->guard = 0;
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    void (*sink_table[4])(long long*) = { store_value, store_value, store_value, store_value };
    sink_table[rand() % 4](&box->payload);
    long long observed = load_outer(&box->payload);
    (void) observed;
}
