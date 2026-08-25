#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 058 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - one read instruction per matrix row
//   Sink   (write): stable   - one write instruction for any row
// Idea:
//   The write uses a computed row index and is therefore a single
//   instruction covering all rows, while the read side has a dedicated
//   instruction per row. Sink stability with a varying address, source
//   volatility with the same address.
// Expected result:
//   VOLATILE. At least one row read instruction is expected to be lost
//   from the sampled dependency set.
// ============================================================

int main() {
    int matrix[4][4];
    for (int i = 0; i < 4; ++i) {
        for (int j = 0; j < 4; ++j) {
            matrix[i][j] = 0;
        }
    }

    int row = rand() % 4;
    matrix[row][2] = 58;                    // Sink

    int consumed = 0;
    if (row == 0) {
        consumed = matrix[0][2];            // Source (row 0)
    } else if (row == 1) {
        consumed = matrix[1][2];            // Source (row 1)
    } else if (row == 2) {
        consumed = matrix[2][2];            // Source (row 2)
    } else {
        consumed = matrix[3][2];            // Source (row 3)
    }
    (void) consumed;
}
