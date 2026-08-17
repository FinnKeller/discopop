#include <stdlib.h>

// Case 9
// Source: not volatile
// Goal: volatile

static int* choose_slot(int* slots[], int index) {
    return slots[index];
}

int main() {
    int stable[4] = {4, 8, 15, 16};
    int left = 0;
    int right = 0;
    int* targets[2] = {&left, &right};

    int value = stable[1] + stable[2]; // Quelle
    int* goal = choose_slot(targets, rand() % 2); // Ziel
    *goal = value;
}
