#include <stdio.h>

// ============================================================
// Case 070 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - one read instruction per recursion parity
//   Sink   (write): stable   - one write instruction in the fill loop
// Idea:
//   A recursive reduction picks its read instruction by the parity of the
//   current depth. Since the starting depth rotates per tick, a given
//   array cell is read by different instructions in different
//   repetitions while the fill instruction never changes.
// Expected result:
//   VOLATILE. At least one of the two parity read instructions is
//   expected to be missing under sampling.
// ============================================================

int reduce(const int* arr, int index) {
    if (index < 0) {
        return 0;
    }
    int local = 0;
    if (index % 2 == 0) {
        local = arr[index];             // Source (even index)
    } else {
        local = arr[index] * 2;         // Source (odd index)
    }
    return local + reduce(arr, index - 1);
}

int main() {
    static int tick = 0;
    int arr[8];
    for (int i = 0; i < 8; ++i) {
        arr[i] = i + 1;                 // Sink
    }
    int total = reduce(arr, 1 + (tick % 7));
    tick = tick + 1;
    (void) total;
}
