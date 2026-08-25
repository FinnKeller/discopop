#include <stdio.h>

// ============================================================
// Case 015 - Volatility split 1: no volatility
//   Source (read) : stable  - one read site inside the helper
//   Sink   (write): stable  - one write site inside the helper
// Idea:
//   One helper is called twice with two different targets. Both calls
//   produce dependencies between the same two instructions, so the two
//   call instances normalize to a single edge. Repetition of an already
//   observed edge cannot be lost from the union.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH.
// ============================================================

int bump(int* target) {
    *target = *target + 1;      // Sink and Source
    return *target;             // Source
}

int main() {
    int a = 0;
    int b = 0;
    int x = bump(&a);
    int y = bump(&b);
    (void) x;
    (void) y;
}
