#include <stdio.h>

// ============================================================
// Case 011 - Volatility split 1: no volatility
//   Source (read) : stable  - one read in main
//   Sink   (write): stable  - one write inside the single callee
// Idea:
//   The write crosses a function boundary but there is only one possible
//   callee, resolved statically. Call-site instrumentation adds section
//   ids and call counters, which the comparison normalizes away, so the
//   dependency reduces to one fixed instruction pair.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH.
// ============================================================

void store(int* target) {
    *target = 31;           // Sink
}

int main() {
    int a = 0;
    store(&a);
    int x = a;              // Source
    (void) x;
}
