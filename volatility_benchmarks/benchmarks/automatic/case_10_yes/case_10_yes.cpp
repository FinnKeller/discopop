#include <stdio.h>
#include <stdlib.h>

// Volatility split: sink volatile only
// Idea behind the example: the write destination is chosen by a runtime branch, while the read always comes from the same stable location.
// Expected result: volatile on the sink side only; the sampling gap can hide or distort the write-to-read relation.

int main() {
    int left = 0;
    int right = 0;
    int *targets[2] = {&left, &right};

    int *p = targets[0];
    int choice = rand() % 2;
    p = targets[choice];

    *p = 7;      // sink (volatile)
    int x = left; // source (stable)

    printf("%d\n", x);
    return x;
}
