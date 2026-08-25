#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 063 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - two read sites inside one callee
//   Sink   (write): stable   - one write instruction in main
// Idea:
//   Exactly one function is called, so the call graph is unambiguous,
//   but the callee contains two read instructions and selects one at
//   runtime. The source volatility is purely intra-procedural.
// Expected result:
//   VOLATILE. One of the two read instructions inside the callee is
//   expected to be missing under sampling.
// ============================================================

int load_either(const int* source, int mode) {
    if (mode == 0) {
        return *source + 10;        // Source (mode 0)
    }
    return *source + 20;            // Source (mode 1)
}

int main() {
    int a = 0;
    a = 63;                         // Sink
    int x = load_either(&a, rand() % 2);
    (void) x;
}
