#include <stdlib.h>

// Case 8
// Source: not volatile
// Goal: not volatile

static int* advance(int* base, int offset) {
    return base + offset;
}

int main() {
    int data[6] = {0, 1, 2, 3, 4, 5};
    int* source = advance(&data[0], 2);
    int value = *source; // Quelle

    int* goal = advance(&data[0], 4);
    *goal = value; // Ziel
}
