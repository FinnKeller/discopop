#include <stdlib.h>

// ==========================================================
// Case 240 - Volatility split 1: no volatility
//   Source (read) : stable  - a read two call levels down
//   Sink   (write): stable  - an assignment through one of two pointers that denote the same object
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over the value member of a stack union.
//   The write is an assignment through one of two pointers that denote
//   the same object and the read is a read two call levels down. Added
//   noise: a random branch that only ever touches an unrelated scratch
//   variable. Nothing in the program can make a different instruction
//   take either end of the dependency, so the reported dependency
//   structure cannot depend on which accesses a sampling window
//   happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

union Slot { unsigned int as_value; unsigned char raw[sizeof(unsigned int)]; };

static unsigned int load_inner(const unsigned int* source) {
    return *source;        // Source
}

static unsigned int load_outer(const unsigned int* source) {
    return load_inner(source);
}

int main() {
    Slot slot;
    int scratch = 0;
    if (rand() % 2 == 0) { scratch = 1; } else { scratch = 2; }
    (void) scratch;
    unsigned int* alias_a = &slot.as_value;
    unsigned int* alias_b = &slot.as_value;
    unsigned int* chosen = (rand() % 2 == 0) ? alias_a : alias_b;
    *chosen = 51;        // Sink
    unsigned int observed = load_outer(&slot.as_value);
    (void) observed;
}
