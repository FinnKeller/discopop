#include <stdio.h>

// ============================================================
// Case 048 - Volatility split 2: sink volatile only
//   Source (read) : stable   - one read in main
//   Sink   (write): VOLATILE - one of three capture free lambdas
// Idea:
//   Capture free lambdas decay to function pointers and are collected in
//   a table. The selected lambda body holds the write, so the sink line
//   rotates while the read stays fixed. Same shape as the function
//   pointer table but through lambda bodies.
// Expected result:
//   VOLATILE. At least one lambda write line is expected to be lost from
//   the sampled dependency set.
// ============================================================

typedef void (*StoreFn)(int*);

static StoreFn make_table_slot(int index) {
    StoreFn table[3] = {
        [](int* target) { *target = 11; },      // Sink (lambda 0)
        [](int* target) { *target = 12; },      // Sink (lambda 1)
        [](int* target) { *target = 13; }       // Sink (lambda 2)
    };
    return table[index];
}

int main() {
    static int tick = 0;
    int a = 0;
    StoreFn fn = make_table_slot(tick % 3);
    fn(&a);
    int x = a;                                  // Source
    tick = tick + 1;
    (void) x;
}
