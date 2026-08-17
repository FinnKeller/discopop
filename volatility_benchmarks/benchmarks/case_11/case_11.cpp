#include <stdlib.h>

// Case 11
// Source: volatile
// Goal: volatile

static int* select_source(int* options[], int index) {
    return options[index];
}

static int* select_goal(int* options[], int index) {
    return options[index];
}

int main() {
    int data[6] = {2, 4, 6, 8, 10, 12};
    int out_a = 0;
    int out_b = 0;
    int* sources[2] = {&data[1], &data[4]};
    int* goals[2] = {&out_a, &out_b};

    int value = *select_source(sources, rand() % 2); // Quelle
    int* goal = select_goal(goals, rand() % 2); // Ziel
    *goal = value;
}
