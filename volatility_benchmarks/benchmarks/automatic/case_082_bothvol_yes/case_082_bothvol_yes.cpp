#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 082 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - ascending or descending scan
//   Sink   (write): VOLATILE - dense or sparse fill
// Idea:
//   Two loop shapes on each end. The fill uses either stride one or
//   stride two and the scan runs either forwards or backwards, so both
//   the reported write line and the reported read line depend on runtime
//   choices, and the traversal order interacts with the windows.
// Expected result:
//   VOLATILE. Several of the four loop combinations are expected to be
//   under-reported under sampling.
// ============================================================

int main() {
    static int arr[24];

    if (rand() % 2 == 0) {
        for (int i = 0; i < 24; i += 1) {
            arr[i] = i;                     // Sink (dense fill)
        }
    } else {
        for (int i = 0; i < 24; i += 2) {
            arr[i] = i * 2;                 // Sink (sparse fill)
        }
    }

    int total = 0;
    if (rand() % 2 == 0) {
        for (int i = 0; i < 24; ++i) {
            total += arr[i];                // Source (ascending scan)
        }
    } else {
        for (int i = 23; i >= 0; --i) {
            total += arr[i];                // Source (descending scan)
        }
    }
    (void) total;
}
