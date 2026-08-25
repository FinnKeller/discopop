#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 005 - Volatility split 1: no volatility
//   Source (read) : stable  - one read of the heap cell
//   Sink   (write): stable  - one write of the heap cell
// Idea:
//   The dependency lives on a heap cell whose address changes from
//   repetition to repetition. The *addresses* differ but the pair of
//   instructions does not, so the reported dependency is identical.
//   This checks that address instability alone is not volatility.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH.
// ============================================================

int main() {
    int* cell = new int(0);
    *cell = 13;         // Sink
    int x = *cell;      // Source
    delete cell;
    (void) x;
}
