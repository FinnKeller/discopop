#include <stdlib.h>

// ==========================================================
// Case 155 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a reader function
//   Sink   (write): stable  - an assignment through one of two pointers that denote the same object
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a malloc'ed cell released per
//   repetition. The write is an assignment through one of two pointers
//   that denote the same object and the read is a read inside a reader
//   function. Added noise: a second, completely separate write/read
//   pair on an unrelated variable. Nothing in the program can make a
//   different instruction take either end of the dependency, so the
//   reported dependency structure cannot depend on which accesses a
//   sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static char load_value(const char* source) {
    return *source;        // Source
}

int main() {
    char* cell = (char*) malloc(sizeof(char));
    *cell = 0;
    int companion = 0;
    companion = 271;
    int companion_seen = companion;
    (void) companion_seen;
    char* alias_a = cell;
    char* alias_b = cell;
    char* chosen = (rand() % 2 == 0) ? alias_a : alias_b;
    *chosen = 47;        // Sink
    char observed = load_value(cell);
    (void) observed;
    free(cell);
}
