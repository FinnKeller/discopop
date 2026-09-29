#include <stdlib.h>

// ==========================================================
// Case 130 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a reader function
//   Sink   (write): stable  - an assignment through one of two pointers that denote the same object
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a translation unit global scalar.
//   The write is an assignment through one of two pointers that denote
//   the same object and the read is a read inside a reader function.
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

static char g_cell;

static char load_value(const char* source) {
    return *source;        // Source
}

int main() {
    g_cell = 0;
    int companion = 0;
    companion = 271;
    int companion_seen = companion;
    (void) companion_seen;
    char* alias_a = &g_cell;
    char* alias_b = &g_cell;
    char* chosen = (rand() % 2 == 0) ? alias_a : alias_b;
    *chosen = 42;        // Sink
    char observed = load_value(&g_cell);
    (void) observed;
}
