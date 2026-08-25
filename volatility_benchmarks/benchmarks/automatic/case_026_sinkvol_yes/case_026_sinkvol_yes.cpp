#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 026 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a single read instruction
//   Sink   (write): VOLATILE - one of eight write instructions
// Idea:
//   Eight scalars, each written by its own instruction, and a pointer
//   table selected at runtime. The single read therefore reports one of
//   eight different write lines. Each individual edge occurs in only an
//   eighth of the repetitions, so an off-window that hides one variant
//   removes a distinct edge from the union instead of a duplicate.
// Expected result:
//   VOLATILE. Some of the eight write lines are expected to disappear
//   from the sampled dependency set for at least one batch size.
// ============================================================

int main() {
    int s0 = 0;     // Sink candidate 0
    int s1 = 1;     // Sink candidate 1
    int s2 = 2;     // Sink candidate 2
    int s3 = 3;     // Sink candidate 3
    int s4 = 4;     // Sink candidate 4
    int s5 = 5;     // Sink candidate 5
    int s6 = 6;     // Sink candidate 6
    int s7 = 7;     // Sink candidate 7

    int* table[8] = { &s0, &s1, &s2, &s3, &s4, &s5, &s6, &s7 };
    int* selected = table[rand() % 8];
    int x = *selected;      // Source
    (void) x;
}
