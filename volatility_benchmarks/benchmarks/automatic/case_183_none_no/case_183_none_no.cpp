#include <stdlib.h>

// ==========================================================
// Case 183 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a lambda
//   Sink   (write): stable  - an assignment reached through a randomly indexed table whose slots are all the same function
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a translation unit global scalar.
//   The write is an assignment reached through a randomly indexed
//   table whose slots are all the same function and the read is a read
//   inside a lambda. Added noise: a random branch that only ever
//   touches an unrelated scratch variable. Nothing in the program can
//   make a different instruction take either end of the dependency, so
//   the reported dependency structure cannot depend on which accesses
//   a sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static unsigned int g_cell;

static void store_value(unsigned int* target) {
    *target = 36;        // Sink
}

int main() {
    g_cell = 0;
    int scratch = 0;
    if (rand() % 2 == 0) { scratch = 1; } else { scratch = 2; }
    (void) scratch;
    void (*sink_table[4])(unsigned int*) = { store_value, store_value, store_value, store_value };
    sink_table[rand() % 4](&g_cell);
    auto src_lambda = [](const unsigned int* source) { return *source; };        // Source
    unsigned int observed = src_lambda(&g_cell);
    (void) observed;
}
