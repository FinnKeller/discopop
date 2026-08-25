#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 083 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - one read instruction per matrix row
//   Sink   (write): VOLATILE - one write instruction per matrix row
// Idea:
//   Both ends have a dedicated instruction per row, and the row is
//   selected at runtime. Unlike the independent choices of case 081 the
//   two ends are correlated here: the edge is always a diagonal pair, so
//   only four of the sixteen combinations ever occur.
// Expected result:
//   VOLATILE. At least one of the four diagonal edges is expected to be
//   missing under sampling.
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
        matrix[0][3] = 30;                  // Sink (row 0)
    } else if (row == 1) {
        matrix[1][3] = 31;                  // Sink (row 1)
    } else if (row == 2) {
        matrix[2][3] = 32;                  // Sink (row 2)
    } else {
        matrix[3][3] = 33;                  // Sink (row 3)
    }

    int consumed = 0;
    if (row == 0) {
        consumed = matrix[0][3];            // Source (row 0)
    } else if (row == 1) {
        consumed = matrix[1][3];            // Source (row 1)
    } else if (row == 2) {
        consumed = matrix[2][3];            // Source (row 2)
    } else {
        consumed = matrix[3][3];            // Source (row 3)
    }
    (void) consumed;
}
