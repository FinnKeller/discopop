#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 047 - Volatility split 2: sink volatile only
//   Source (read) : stable   - one read through the double indirection
//   Sink   (write): VOLATILE - one write instruction per indirection level
// Idea:
//   A table of pointers to pointers. The write happens either through
//   one or through two levels of indirection, by two different
//   instructions, while the read always uses the full chain. Deep
//   indirection plus sink ambiguity.
// Expected result:
//   VOLATILE. One of the two write lines is expected to disappear under
//   sampling.
// ============================================================

int main() {
    int cell = 0;
    int* direct = &cell;
    int** indirect = &direct;

    if (rand() % 2 == 0) {
        *direct = 31;               // Sink (one level)
    } else {
        **indirect = 32;            // Sink (two levels)
    }

    int x = **indirect;             // Source
    (void) x;
}
