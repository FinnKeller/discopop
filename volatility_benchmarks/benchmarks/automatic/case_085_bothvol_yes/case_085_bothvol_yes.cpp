#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 085 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - one read instruction per index bucket
//   Sink   (write): VOLATILE - one write instruction per index bucket
// Idea:
//   A random index is mapped into three buckets, and each bucket has its
//   own write and its own read instruction. Address, sink and source all
//   move together, which is the most realistic shape: an irregular
//   access pattern in a real program.
// Expected result:
//   VOLATILE. At least one bucket edge is expected to be missing from
//   the sampled dependency set.
// ============================================================

int main() {
    int arr[12];
    for (int i = 0; i < 12; ++i) {
        arr[i] = 0;
    }

    int index = rand() % 12;
    int consumed = 0;

    if (index < 4) {
        arr[index] = 40;                    // Sink (low bucket)
        consumed = arr[index] + 1;          // Source (low bucket)
    } else if (index < 8) {
        arr[index] = 50;                    // Sink (mid bucket)
        consumed = arr[index] + 2;          // Source (mid bucket)
    } else {
        arr[index] = 60;                    // Sink (high bucket)
        consumed = arr[index] + 3;          // Source (high bucket)
    }
    (void) consumed;
}
