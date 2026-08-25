#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 032 - Volatility split 2: sink volatile only
//   Source (read) : stable   - one read through the pointer
//   Sink   (write): VOLATILE - index notation or pointer notation
// Idea:
//   Two syntactically different writes to the very same element, one via
//   subscript and one via dereferenced pointer arithmetic. The address is
//   identical in both cases, so only the instruction identity of the sink
//   changes at runtime.
// Expected result:
//   VOLATILE. One of the two write lines is expected to be missing for
//   at least one batch size.
// ============================================================

int main() {
    int arr[4];
    for (int i = 0; i < 4; ++i) {
        arr[i] = 0;
    }

    int* p = arr + 2;
    if (rand() % 2 == 0) {
        arr[2] = 81;            // Sink (subscript form)
    } else {
        *p = 82;                // Sink (pointer form)
    }

    int x = *p;                 // Source
    (void) x;
}
