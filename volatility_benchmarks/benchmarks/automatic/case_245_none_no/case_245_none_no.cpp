#include <stdlib.h>

// ==========================================================
// Case 245 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a function template instance
//   Sink   (write): stable  - an assignment through one of two pointers that denote the same object
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over the value member of a stack union.
//   The write is an assignment through one of two pointers that denote
//   the same object and the read is a read inside a function template
//   instance. Added noise: a dead store to an unrelated variable.
//   Nothing in the program can make a different instruction take
//   either end of the dependency, so the reported dependency structure
//   cannot depend on which accesses a sampling window happens to
//   catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

union Slot { long as_value; unsigned char raw[sizeof(long)]; };

template <typename V>
static V load_generic(const V* source) {
    return *source;        // Source
}

int main() {
    Slot slot;
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    long* alias_a = &slot.as_value;
    long* alias_b = &slot.as_value;
    long* chosen = (rand() % 2 == 0) ? alias_a : alias_b;
    *chosen = 49;        // Sink
    long observed = load_generic<long>(&slot.as_value);
    (void) observed;
}
