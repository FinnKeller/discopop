#include <stdlib.h>

// ==========================================================
// Case 137 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a local pointer
//   Sink   (write): stable  - a plain assignment
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a stack array element whose index
//   is drawn once and shared by both ends. The write is a plain
//   assignment and the read is a read through a local pointer.
//   Nothing in the program can make a different instruction take
//   either end of the dependency, so the reported dependency structure
//   cannot depend on which accesses a sampling window happens to
//   catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

int main() {
    long long arr[16];
    int idx = rand() % 16;
    arr[idx] = 34;        // Sink
    const long long* src_ptr = &arr[idx];
    long long observed = *src_ptr;        // Source
    (void) observed;
}
