#include <stdlib.h>

// ==========================================================
// Case 290 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a const reference parameter
//   Sink   (write): stable  - an assignment through one of two pointers that denote the same object
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a plain stack scalar. The write is
//   an assignment through one of two pointers that denote the same
//   object and the read is a read through a const reference parameter.
//   Nothing in the program can make a different instruction take
//   either end of the dependency, so the reported dependency structure
//   cannot depend on which accesses a sampling window happens to
//   catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static char load_ref(const char& source) {
    return source;        // Source
}

int main() {
    char cell = 0;
    char* alias_a = &cell;
    char* alias_b = &cell;
    char* chosen = (rand() % 2 == 0) ? alias_a : alias_b;
    *chosen = 38;        // Sink
    char observed = load_ref(cell);
    (void) observed;
}
