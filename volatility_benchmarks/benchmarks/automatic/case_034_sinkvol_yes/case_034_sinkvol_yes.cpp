#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 034 - Volatility split 2: sink volatile only
//   Source (read) : stable   - one read instruction in the scan loop
//   Sink   (write): VOLATILE - a dense or a sparse fill instruction
// Idea:
//   The array is filled either with stride one or with stride three, by
//   two different write instructions. The scan reads every element, so
//   which write line is reported per element depends on the stride that
//   was chosen, and cells not touched by the sparse fill keep the value
//   of an earlier repetition.
// Expected result:
//   VOLATILE. The set of reported write lines per read is expected to
//   shrink under sampling.
// ============================================================

int main() {
    static int arr[24];

    if (rand() % 2 == 0) {
        for (int i = 0; i < 24; i += 1) {
            arr[i] = i;                 // Sink (dense stride)
        }
    } else {
        for (int i = 0; i < 24; i += 3) {
            arr[i] = i * 2;             // Sink (sparse stride)
        }
    }

    int total = 0;
    for (int i = 0; i < 24; ++i) {
        total += arr[i];                // Source
    }
    (void) total;
}
