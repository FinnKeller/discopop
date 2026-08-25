#include <stdio.h>

// ============================================================
// Case 013 - Volatility split 1: no volatility
//   Source (read) : stable  - one read in main
//   Sink   (write): stable  - one write, reached through a function pointer
// Idea:
//   Indirection through a function pointer, but the pointer is assigned
//   a single target and never reassigned. The call is statically opaque
//   yet dynamically deterministic, so the dependency is not volatile.
//   This is the deliberate contrast to the function-pointer *tables*
//   used by the volatile cases.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH.
// ============================================================

void writer(int* target) {
    *target = 55;           // Sink
}

int main() {
    int a = 0;
    void (*fp)(int*) = writer;
    fp(&a);
    int x = a;              // Source
    (void) x;
}
