#include <stdio.h>
#include <stdlib.h>

// Volatility split: source volatile only
// Idea behind the example: the writes always target the same fixed cells, but the read chooses between them at runtime.
// Expected result: volatile on the source side only; the read-side sampling gap can make the observed dependency disappear.

int main() {
    int left = 0;
    int right = 0;
    int *sources[2] = {&left, &right};

    left = 10;
    right = 20;

    int choice = rand() % 2;
    int x = *sources[choice]; // source (volatile)

    printf("%d\n", x);
    return x;
}
