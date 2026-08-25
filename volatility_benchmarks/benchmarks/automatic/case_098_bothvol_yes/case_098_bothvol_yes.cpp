#include <stdio.h>

// ============================================================
// Case 098 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - one of three capture free reader lambdas
//   Sink   (write): VOLATILE - one of three capture free writer lambdas
// Idea:
//   Lambda tables on both ends. The two indices advance with different
//   strides over the ticks, so writer and reader choice are effectively
//   uncorrelated and all nine edges occur with unequal frequency.
// Expected result:
//   VOLATILE. Several of the nine lambda edges are expected to be missing
//   from the sampled dependency set.
// ============================================================

typedef void (*StoreFn)(int*);
typedef int (*LoadFn)(const int*);

static StoreFn pick_storer(int index) {
    StoreFn table[3] = {
        [](int* target) { *target = 1; },        // Sink (lambda 0)
        [](int* target) { *target = 2; },        // Sink (lambda 1)
        [](int* target) { *target = 3; }         // Sink (lambda 2)
    };
    return table[index];
}

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

    StoreFn store = pick_storer(tick % 3);
    LoadFn load = pick_loader((tick * 2) % 3);

    store(&a);
    int x = load(&a);
    tick = tick + 1;
    (void) x;
}
