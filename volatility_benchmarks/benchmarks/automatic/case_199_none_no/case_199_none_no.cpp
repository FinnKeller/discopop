#include <stdlib.h>

// ==========================================================
// Case 199 - Volatility split 1: no volatility
//   Source (read) : stable  - a read reached through a function pointer with a single target
//   Sink   (write): stable  - an assignment two call levels down
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a heap cell whose address moves
//   every repetition. The write is an assignment two call levels down
//   and the read is a read reached through a function pointer with a
//   single target. Added noise: a random branch that only ever touches
//   an unrelated scratch variable. Nothing in the program can make a
//   different instruction take either end of the dependency, so the
//   reported dependency structure cannot depend on which accesses a
//   sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_inner(int* target) {
    *target = 40;        // Sink
}

static void store_outer(int* target) {
    store_inner(target);
}

static int load_value(const int* source) {
    return *source;        // Source
}

int main() {
    int* cell = new int(0);
    int scratch = 0;
    if (rand() % 2 == 0) { scratch = 1; } else { scratch = 2; }
    (void) scratch;
    store_outer(cell);
    int (*src_fp)(const int*) = load_value;
    int observed = src_fp(cell);
    (void) observed;
}
