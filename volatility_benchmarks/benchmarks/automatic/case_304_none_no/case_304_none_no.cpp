#include <stdlib.h>

// ==========================================================
// Case 304 - Volatility split 1: no volatility
//   Source (read) : stable  - a read reached through a function pointer with a single target
//   Sink   (write): stable  - an assignment reached through a randomly indexed table whose slots are all the same function
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a malloc'ed cell released per
//   repetition. The write is an assignment reached through a randomly
//   indexed table whose slots are all the same function and the read
//   is a read reached through a function pointer with a single target.
//   Added noise: a second, completely separate write/read pair on an
//   unrelated variable. Nothing in the program can make a different
//   instruction take either end of the dependency, so the reported
//   dependency structure cannot depend on which accesses a sampling
//   window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_value(int* target) {
    *target = 41;        // Sink
}

static int load_value(const int* source) {
    return *source;        // Source
}

int main() {
    int* cell = (int*) malloc(sizeof(int));
    *cell = 0;
    int companion = 0;
    companion = 271;
    int companion_seen = companion;
    (void) companion_seen;
    void (*sink_table[4])(int*) = { store_value, store_value, store_value, store_value };
    sink_table[rand() % 4](cell);
    int (*src_fp)(const int*) = load_value;
    int observed = src_fp(cell);
    (void) observed;
    free(cell);
}
