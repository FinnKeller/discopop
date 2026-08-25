#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 039 - Volatility split 2: sink volatile only
//   Source (read) : stable   - one read in main
//   Sink   (write): VOLATILE - two write sites inside one callee
// Idea:
//   Only one function is ever called, so the call graph is unambiguous,
//   but the function contains two write instructions and picks one at
//   runtime. The sink volatility is entirely intra-procedural, which no
//   call-site based reasoning can see.
// Expected result:
//   VOLATILE. One of the two intra-procedural write lines is expected to
//   be missing for at least one batch size.
// ============================================================

void store_either(int* target, int mode) {
    if (mode == 0) {
        *target = 41;           // Sink (mode 0)
    } else {
        *target = 42;           // Sink (mode 1)
    }
}

int main() {
    int a = 0;
    store_either(&a, rand() % 2);
    int x = a;                  // Source
    (void) x;
}
