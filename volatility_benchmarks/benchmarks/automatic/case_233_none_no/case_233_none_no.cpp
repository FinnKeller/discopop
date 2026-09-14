#include <stdlib.h>

// ==========================================================
// Case 233 - Volatility split 1: no volatility
//   Source (read) : stable  - a read two call levels down
//   Sink   (write): stable  - an assignment reached through a randomly indexed table whose slots are all the same function
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a function local static scalar.
//   The write is an assignment reached through a randomly indexed
//   table whose slots are all the same function and the read is a read
//   two call levels down. Added noise: a second, completely separate
//   write/read pair on an unrelated variable. Nothing in the program
//   can make a different instruction take either end of the
//   dependency, so the reported dependency structure cannot depend on
//   which accesses a sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_value(unsigned int* target) {
    *target = 40;        // Sink
}

static unsigned int load_inner(const unsigned int* source) {
    return *source;        // Source
}

static unsigned int load_outer(const unsigned int* source) {
    return load_inner(source);
}

int main() {
    static unsigned int cell;
    cell = 0;
    int companion = 0;
    companion = 271;
    int companion_seen = companion;
    (void) companion_seen;
    void (*sink_table[4])(unsigned int*) = { store_value, store_value, store_value, store_value };
    sink_table[rand() % 4](&cell);
    unsigned int observed = load_outer(&cell);
    (void) observed;
}
