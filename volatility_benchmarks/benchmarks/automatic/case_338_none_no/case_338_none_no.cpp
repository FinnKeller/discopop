#include <stdlib.h>

// ==========================================================
// Case 338 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a reader function
//   Sink   (write): stable  - an assignment through a local pointer
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a stack array element whose index
//   is drawn once and shared by both ends. The write is an assignment
//   through a local pointer and the read is a read inside a reader
//   function. Added noise: a dead store to an unrelated variable.
//   Nothing in the program can make a different instruction take
//   either end of the dependency, so the reported dependency structure
//   cannot depend on which accesses a sampling window happens to
//   catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static short load_value(const short* source) {
    return *source;        // Source
}

int main() {
    short arr[16];
    int idx = rand() % 16;
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    short* sink_ptr = &arr[idx];
    *sink_ptr = 36;        // Sink
    short observed = load_value(&arr[idx]);
    (void) observed;
}
