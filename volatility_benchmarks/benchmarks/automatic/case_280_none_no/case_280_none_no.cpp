#include <stdlib.h>

// ==========================================================
// Case 280 - Volatility split 1: no volatility
//   Source (read) : stable  - a read reached through a function pointer with a single target
//   Sink   (write): stable  - an assignment through one of two pointers that denote the same object
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a function local static scalar.
//   The write is an assignment through one of two pointers that denote
//   the same object and the read is a read reached through a function
//   pointer with a single target. Added noise: a second, completely
//   separate write/read pair on an unrelated variable. Nothing in the
//   program can make a different instruction take either end of the
//   dependency, so the reported dependency structure cannot depend on
//   which accesses a sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static long load_value(const long* source) {
    return *source;        // Source
}

int main() {
    static long cell;
    cell = 0;
    int companion = 0;
    companion = 271;
    int companion_seen = companion;
    (void) companion_seen;
    long* alias_a = &cell;
    long* alias_b = &cell;
    long* chosen = (rand() % 2 == 0) ? alias_a : alias_b;
    *chosen = 40;        // Sink
    long (*src_fp)(const long*) = load_value;
    long observed = src_fp(&cell);
    (void) observed;
}
