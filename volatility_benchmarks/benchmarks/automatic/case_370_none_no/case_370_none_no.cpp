#include <stdlib.h>

// ==========================================================
// Case 370 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a const reference parameter
//   Sink   (write): stable  - an assignment inside a function template instance
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a stack array element whose index
//   is drawn once and shared by both ends. The write is an assignment
//   inside a function template instance and the read is a read through
//   a const reference parameter.  Nothing in the program can make a
//   different instruction take either end of the dependency, so the
//   reported dependency structure cannot depend on which accesses a
//   sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

template <typename V>
static void store_generic(V* target, V value) {
    *target = value;        // Sink
}

static unsigned int load_ref(const unsigned int& source) {
    return source;        // Source
}

int main() {
    unsigned int arr[16];
    int idx = rand() % 16;
    store_generic<unsigned int>(&arr[idx], 44);
    unsigned int observed = load_ref(arr[idx]);
    (void) observed;
}
