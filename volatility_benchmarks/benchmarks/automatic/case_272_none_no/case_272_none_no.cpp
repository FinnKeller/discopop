#include <stdlib.h>

// ==========================================================
// Case 272 - Volatility split 1: no volatility
//   Source (read) : stable  - a plain read
//   Sink   (write): stable  - a plain assignment
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a stack array element whose index
//   is drawn once and shared by both ends. The write is a plain
//   assignment and the read is a plain read. Added noise: a second,
//   completely separate write/read pair on an unrelated variable.
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
    unsigned int arr[16];
    int idx = rand() % 16;
    int companion = 0;
    companion = 271;
    int companion_seen = companion;
    (void) companion_seen;
    arr[idx] = 35;        // Sink
    unsigned int observed = arr[idx];        // Source
    (void) observed;
}
