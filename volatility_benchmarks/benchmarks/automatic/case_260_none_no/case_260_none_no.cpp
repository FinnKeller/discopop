#include <stdlib.h>

// ==========================================================
// Case 260 - Volatility split 1: no volatility
//   Source (read) : stable  - a read reached through a function pointer with a single target
//   Sink   (write): stable  - an assignment inside a function template instance
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a function local static scalar.
//   The write is an assignment inside a function template instance and
//   the read is a read reached through a function pointer with a
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

template <typename V>
static void store_generic(V* target, V value) {
    *target = value;        // Sink
}

static char load_value(const char* source) {
    return *source;        // Source
}

int main() {
    static char cell;
    cell = 0;
    int scratch = 0;
    if (rand() % 2 == 0) { scratch = 1; } else { scratch = 2; }
    (void) scratch;
    store_generic<char>(&cell, 41);
    char (*src_fp)(const char*) = load_value;
    char observed = src_fp(&cell);
    (void) observed;
}
