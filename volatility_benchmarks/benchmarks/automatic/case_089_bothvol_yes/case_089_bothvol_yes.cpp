#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 089 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two read sites inside one reader
//   Sink   (write): VOLATILE - two write sites inside one writer
// Idea:
//   The call graph is completely unambiguous - one writer and one reader
//   are called - but each of them contains two candidate instructions and
//   picks one at runtime. Both ends are volatile without any indirect
//   call being involved.
// Expected result:
//   VOLATILE. At least one of the four intra-procedural combinations is
//   expected to be missing under sampling.
// ============================================================

static void store_either(int* target, int mode) {
    if (mode == 0) {
        *target = 91;               // Sink (mode 0)
    } else {
        *target = 92;               // Sink (mode 1)
    }
}

static int fetch_either(const int* source, int mode) {
    if (mode == 0) {
        return *source + 1;         // Source (mode 0)
    }
    return *source + 2;             // Source (mode 1)
}

int main() {
    int a = 0;
    store_either(&a, rand() % 2);
    int x = fetch_either(&a, rand() % 2);
    (void) x;
}
