#include <stdio.h>
#include <stdlib.h>

// Volatility split: both volatile
// Idea behind the example: both the write target and the later read target vary independently at runtime, creating a true mixed-volatility case.
// Expected result: volatile; the dependency relationship is unstable on both sides under sampling.

int main() {
    int left = 0;
    int right = 0;
    int *targets[2] = {&left, &right};
    int *sources[2] = {&left, &right};

    int sink_choice = rand() % 2;
    int src_choice = rand() % 2;

    *targets[sink_choice] = 99; // sink (volatile)
    int x = *sources[src_choice]; // source (volatile)

    printf("%d\n", x);
    return x;
}
