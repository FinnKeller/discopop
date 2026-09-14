#include <stdlib.h>

// ==========================================================
// Case 362 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a local pointer
//   Sink   (write): stable  - an assignment through a three hop pointer chain
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a stack array element whose index
//   is drawn once and shared by both ends. The write is an assignment
//   through a three hop pointer chain and the read is a read through a
//   local pointer.  Nothing in the program can make a different
//   instruction take either end of the dependency, so the reported
//   dependency structure cannot depend on which accesses a sampling
//   window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

int main() {
    unsigned int arr[16];
    int idx = rand() % 16;
    unsigned int* hop_a = &arr[idx];
    unsigned int* hop_b = hop_a;
    unsigned int* hop_c = hop_b;
    *hop_c = 35;        // Sink
    const unsigned int* src_ptr = &arr[idx];
    unsigned int observed = *src_ptr;        // Source
    (void) observed;
}
