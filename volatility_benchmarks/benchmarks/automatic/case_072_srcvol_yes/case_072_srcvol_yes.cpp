#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 072 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - one or two levels of indirection
//   Sink   (write): stable   - one write instruction
// Idea:
//   The value is read either through a single pointer or through a
//   pointer to pointer, by two different instructions. The write always
//   uses the same instruction, so the indirection depth of the reader is
//   the only thing that changes.
// Expected result:
//   VOLATILE. One of the two read instructions is expected to disappear
//   under sampling.
// ============================================================

int main() {
    int cell = 0;
    int* direct = &cell;
    int** indirect = &direct;

    *direct = 72;                   // Sink

    int consumed = 0;
    if (rand() % 2 == 0) {
        consumed = *direct;         // Source (one level)
    } else {
        consumed = **indirect;      // Source (two levels)
    }
    (void) consumed;
}
