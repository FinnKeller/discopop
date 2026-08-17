#include <stdlib.h>

// Case 10
// Source: volatile
// Goal: not volatile

static int read_value(int* values, int index) {
    return values[index];
}

int main() {
    int values[5] = {3, 6, 9, 12, 15};
    int sink = 0;
    int* goal = &sink; // Ziel

    int value = read_value(values, rand() % 5); // Quelle
    *goal = value;
}
