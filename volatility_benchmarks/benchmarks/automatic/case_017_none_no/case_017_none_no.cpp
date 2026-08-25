#include <stdio.h>

// ============================================================
// Case 017 - Volatility split 1: no volatility
//   Source (read) : stable  - one read instruction in the recursion
//   Sink   (write): stable  - one write instruction in the recursion
// Idea:
//   Recursion with a fixed depth writes and reads array cells. Each
//   recursion level uses the same two instructions, so the whole
//   recursion tree collapses to one normalized dependency edge.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH.
// ============================================================

void fill_down(int* arr, int index) {
    if (index < 0) {
        return;
    }
    arr[index] = index * index;      // Sink
    fill_down(arr, index - 1);
}

int sum_up(const int* arr, int index) {
    if (index < 0) {
        return 0;
    }
    return arr[index] + sum_up(arr, index - 1);      // Source
}

int main() {
    int arr[6];
    fill_down(arr, 5);
    int total = sum_up(arr, 5);
    (void) total;
}
