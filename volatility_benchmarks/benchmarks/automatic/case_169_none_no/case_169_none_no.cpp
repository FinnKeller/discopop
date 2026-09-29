#include <stdlib.h>

// ==========================================================
// Case 169 - Volatility split 1: no volatility
//   Source (read) : stable  - a read reached through a function pointer with a single target
//   Sink   (write): stable  - an assignment through a reference parameter
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a malloc'ed cell released per
//   repetition. The write is an assignment through a reference
//   parameter and the read is a read reached through a function
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

static void store_ref(char& target) {
    target = 44;        // Sink
}

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
    store_ref(*cell);
    char (*src_fp)(const char*) = load_value;
    char observed = src_fp(cell);
    (void) observed;
    free(cell);
}
