#include <stdio.h>

// ============================================================
// Case 073 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - one of three capture free lambdas
//   Sink   (write): stable   - one write instruction in main
// Idea:
//   Capture free lambdas decay to function pointers and are collected in
//   a table. The selected lambda body performs the read, so the source
//   instruction rotates while the write stays fixed.
// Expected result:
//   VOLATILE. At least one lambda read instruction is expected to be
//   missing under sampling.
// ============================================================

typedef int (*LoadFn)(const int*);

static LoadFn pick_loader(int index) {
    LoadFn table[3] = {
        [](const int* source) { return *source + 1; },       // Source (lambda 0)
        [](const int* source) { return *source + 2; },       // Source (lambda 1)
        [](const int* source) { return *source + 3; }        // Source (lambda 2)
    };
    return table[index];
}

int main() {
    static int tick = 0;
    int a = 0;
    a = 73;                                                  // Sink
    LoadFn fn = pick_loader(tick % 3);
    int x = fn(&a);
    tick = tick + 1;
    (void) x;
}
