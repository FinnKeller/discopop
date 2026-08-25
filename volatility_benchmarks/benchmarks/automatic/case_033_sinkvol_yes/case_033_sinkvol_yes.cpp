#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 033 - Volatility split 2: sink volatile only
//   Source (read) : stable   - one read of the selected matrix cell
//   Sink   (write): VOLATILE - one write instruction per matrix row
// Idea:
//   A row of a matrix is selected at runtime and each row has its own
//   dedicated write instruction. The read uses the same selected row, so
//   the source stays a single instruction while the sink rotates through
//   four candidates.
// Expected result:
//   VOLATILE. At least one row write line is expected to disappear from
//   the sampled dependency set.
// ============================================================

int main() {
    int matrix[4][4];
    for (int i = 0; i < 4; ++i) {
        for (int j = 0; j < 4; ++j) {
            matrix[i][j] = 0;
        }
    }

    int row = rand() % 4;
    if (row == 0) {
        matrix[0][1] = 90;          // Sink (row 0)
    } else if (row == 1) {
        matrix[1][1] = 91;          // Sink (row 1)
    } else if (row == 2) {
        matrix[2][1] = 92;          // Sink (row 2)
    } else {
        matrix[3][1] = 93;          // Sink (row 3)
    }

    int x = matrix[row][1];         // Source
    (void) x;
}
