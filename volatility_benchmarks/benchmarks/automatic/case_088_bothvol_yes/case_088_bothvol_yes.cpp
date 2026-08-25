#include <stdio.h>

// ============================================================
// Case 088 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - one of two readers behind a dispatcher
//   Sink   (write): VOLATILE - one of two writers behind a dispatcher
// Idea:
//   Both ends sit two call frames away from main, behind their own
//   dispatcher. Neither end of the dependency is in the same function as
//   the other, and both are chosen at runtime, which stresses call-site
//   bookkeeping and sampling at the same time.
// Expected result:
//   VOLATILE. Several of the four dispatcher combinations are expected
//   to be missing under sampling.
// ============================================================

static void leaf_store_a(int* target) { *target = 7; }              // Sink (leaf a)
static void leaf_store_b(int* target) { *target = 8; }              // Sink (leaf b)

static int leaf_fetch_a(const int* source) { return *source + 1; }  // Source (leaf a)
static int leaf_fetch_b(const int* source) { return *source + 2; }  // Source (leaf b)

static void store_dispatch(int* target, int selector) {
    if (selector == 0) {
        leaf_store_a(target);
    } else {
        leaf_store_b(target);
    }
}

static int fetch_dispatch(const int* source, int selector) {
    if (selector == 0) {
        return leaf_fetch_a(source);
    }
    return leaf_fetch_b(source);
}

int main() {
    static int tick = 0;
    int a = 0;
    store_dispatch(&a, tick % 2);
    int x = fetch_dispatch(&a, (tick / 2) % 2);
    tick = tick + 1;
    (void) x;
}
