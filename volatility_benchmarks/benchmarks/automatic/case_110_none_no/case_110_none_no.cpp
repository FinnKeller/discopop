#include <stdlib.h>

// ==========================================================
// Case 110 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a function template instance
//   Sink   (write): stable  - an assignment through one of two pointers that denote the same object
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a function local static scalar.
//   The write is an assignment through one of two pointers that denote
//   the same object and the read is a read inside a function template
//   instance.  Nothing in the program can make a different instruction
//   take either end of the dependency, so the reported dependency
//   structure cannot depend on which accesses a sampling window
//   happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

template <typename V>
static V load_generic(const V* source) {
    return *source;        // Source
}

int main() {
    static long long cell;
    cell = 0;
    long long* alias_a = &cell;
    long long* alias_b = &cell;
    long long* chosen = (rand() % 2 == 0) ? alias_a : alias_b;
    *chosen = 41;        // Sink
    long long observed = load_generic<long long>(&cell);
    (void) observed;
}
