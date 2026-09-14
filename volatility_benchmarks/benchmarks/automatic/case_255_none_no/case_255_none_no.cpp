#include <stdlib.h>

// ==========================================================
// Case 255 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a function template instance
//   Sink   (write): stable  - an assignment through one of two pointers that denote the same object
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over the value member of a stack union.
//   The write is an assignment through one of two pointers that denote
//   the same object and the read is a read inside a function template
//   instance. Added noise: a random branch that only ever touches an
//   unrelated scratch variable. Nothing in the program can make a
//   different instruction take either end of the dependency, so the
//   reported dependency structure cannot depend on which accesses a
//   sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

union Slot { short as_value; unsigned char raw[sizeof(short)]; };

template <typename V>
static V load_generic(const V* source) {
    return *source;        // Source
}

int main() {
    Slot slot;
    int scratch = 0;
    if (rand() % 2 == 0) { scratch = 1; } else { scratch = 2; }
    (void) scratch;
    short* alias_a = &slot.as_value;
    short* alias_b = &slot.as_value;
    short* chosen = (rand() % 2 == 0) ? alias_a : alias_b;
    *chosen = 49;        // Sink
    short observed = load_generic<short>(&slot.as_value);
    (void) observed;
}
