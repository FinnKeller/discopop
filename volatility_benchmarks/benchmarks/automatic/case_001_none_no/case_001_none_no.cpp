#include <stdio.h>

// ============================================================
// Case 001 - Volatility split 1: no volatility
//   Source (read) : stable  - exactly one read site
//   Sink   (write): stable  - exactly one write site
// Idea:
//   Two-hop pointer alias chain (a <- p <- q) over a single scalar.
//   The address is written at one line only and read at one line only,
//   so the endpoints of the RAW dependency can never change identity.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Sampling may drop individual
//   occurrences, but the identical edge recurs in every repetition and
//   is re-observed in the next on-window, so the union does not change.
// ============================================================

int main() {
    int a;
    int* p = &a;
    int* q = p;
    *q = 7;         // Sink
    int x = *q;     // Source
    (void) x;
}
