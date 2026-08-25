#include <stdio.h>

// ============================================================
// Case 003 - Volatility split 1: no volatility
//   Source (read) : stable  - two read sites, each tied to one address
//   Sink   (write): stable  - two write sites, each tied to one address
// Idea:
//   Two completely independent write/read pairs on two distinct scalars.
//   There is ambiguity in the *number* of dependencies but none in their
//   endpoints: each address has a single writer line and a single reader
//   line, so no runtime choice can swap the partners.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both edges recur in every
//   repetition, so neither can be lost from the union.
// ============================================================

int main() {
    int a = 0;
    int b = 0;
    int* pa = &a;
    int* pb = &b;
    *pa = 11;        // Sink (for a)
    *pb = 22;        // Sink (for b)
    int x = *pa;     // Source (for a)
    int y = *pb;     // Source (for b)
    (void) x;
    (void) y;
}
