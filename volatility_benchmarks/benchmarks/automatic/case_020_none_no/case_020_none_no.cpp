#include <stdio.h>

// ============================================================
// Case 020 - Volatility split 1: no volatility
//   Source (read) : stable  - the accumulation read of the result cell
//   Sink   (write): stable  - the accumulation write of the result cell
// Idea:
//   A small matrix multiplication. The innermost statement is both the
//   sink and the source of the loop-carried dependency on the result
//   cell, and the operand reads all come from one instruction each.
//   Nested loops produce many accesses but no endpoint ambiguity.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH.
// ============================================================

int main() {
    int lhs[2][2];
    int rhs[2][2];
    int result[2][2];

    for (int i = 0; i < 2; ++i) {
        for (int j = 0; j < 2; ++j) {
            lhs[i][j] = i + j;
            rhs[i][j] = i * 2 + j;
            result[i][j] = 0;
        }
    }

    for (int i = 0; i < 2; ++i) {
        for (int j = 0; j < 2; ++j) {
            for (int k = 0; k < 2; ++k) {
                result[i][j] += lhs[i][k] * rhs[k][j];   // Sink and Source
            }
        }
    }
    (void) result[0][0];
}
