#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 053 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - subscript form or pointer form
//   Sink   (write): stable   - a single write instruction
// Idea:
//   The same address is read by two syntactically different
//   instructions, one via subscript and one via a dereferenced pointer.
//   The address is identical in both cases, so nothing but the identity
//   of the source instruction changes.
// Expected result:
//   VOLATILE. One of the two read instructions is expected to be missing
//   for at least one batch size.
// ============================================================

int main() {
    int arr[4];
    for (int i = 0; i < 4; ++i) {
        arr[i] = 0;
    }

    int* p = arr + 1;
    arr[1] = 45;                    // Sink

    int consumed = 0;
    if (rand() % 2 == 0) {
        consumed = arr[1];          // Source (subscript form)
    } else {
        consumed = *p;              // Source (pointer form)
    }
    (void) consumed;
}
