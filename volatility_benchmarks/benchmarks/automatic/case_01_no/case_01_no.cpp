#include <stdio.h>

// Volatility split: no volatility
// Idea behind the example: the same pointer walks a fixed array, and the write/read pattern is consistent across the whole loop.
// Expected result: stable; the looped dependencies should be preserved with or without sampling.

int main() {
    int data[4] = {0, 0, 0, 0};
    int *ptr = data;

    for (int i = 0; i < 4; ++i) {
        ptr[i] = i + 1;  // sink
    }

    int total = 0;
    for (int i = 0; i < 4; ++i) {
        total += ptr[i]; // source
    }

    printf("%d\n", total);
    return total;
}
