#include <stdio.h>

// Volatility split: no volatility
// Idea behind the example: a single pointer is fixed to a single location, so both the write and read observe the same memory cell in all runs.
// Expected result: stable; the dependency structure should not change when sampling is enabled.

int main() {
    int a = 0;
    int *p = &a;

    a = 42;      // sink
    int x = *p;  // source

    printf("%d\n", x);
    return x;
}
