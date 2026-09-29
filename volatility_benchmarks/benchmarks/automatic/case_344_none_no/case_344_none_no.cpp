#include <stdlib.h>

// ==========================================================
// Case 344 - Volatility split 1: no volatility
//   Source (read) : stable  - a read two call levels down
//   Sink   (write): stable  - a plain assignment
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a field of a heap struct. The
//   write is a plain assignment and the read is a read two call levels
//   down. Added noise: a random branch that only ever touches an
//   unrelated scratch variable. Nothing in the program can make a
//   different instruction take either end of the dependency, so the
//   reported dependency structure cannot depend on which accesses a
//   sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

struct Box { int guard; int payload; };

static int load_inner(const int* source) {
    return *source;        // Source
}

static int load_outer(const int* source) {
    return load_inner(source);
}

int main() {
    Box* box = new Box;
    box->guard = 0;
    int scratch = 0;
    if (rand() % 2 == 0) { scratch = 1; } else { scratch = 2; }
    (void) scratch;
    box->payload = 36;        // Sink
    int observed = load_outer(&box->payload);
    (void) observed;
}
