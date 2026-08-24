#include <stdio.h>
#include <stdlib.h>

// Volatility split: both volatile
// Idea behind the example: a small matrix makes the write and read address choices more complex and less obviously paired, stressing the profiler under sampling.
// Expected result: volatile; the random write and read locations should not remain equivalent when sampling is enabled.

int main() {
    int matrix[3][2] = {{0, 0}, {0, 0}, {0, 0}};

    int write_row = rand() % 3;
    int write_col = rand() % 2;
    int read_row = rand() % 3;
    int read_col = rand() % 2;

    matrix[write_row][write_col] = 5; // sink (volatile)
    int x = matrix[read_row][read_col]; // source (volatile)

    printf("%d\n", x);
    return x;
}
