#include <stdlib.h>

// ==========================================================
// Case 135 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a function template instance
//   Sink   (write): stable  - a plain assignment
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over one element of a stack array. The
//   write is a plain assignment and the read is a read inside a
//   function template instance. Added noise: a random branch that only
//   ever touches an unrelated scratch variable. Nothing in the program
//   can make a different instruction take either end of the
//   dependency, so the reported dependency structure cannot depend on
//   which accesses a sampling window happens to catch.
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
    int arr[16];
    int scratch = 0;
    if (rand() % 2 == 0) { scratch = 1; } else { scratch = 2; }
    (void) scratch;
    arr[7] = 30;        // Sink
    int observed = load_generic<int>(&arr[7]);
    (void) observed;
}
