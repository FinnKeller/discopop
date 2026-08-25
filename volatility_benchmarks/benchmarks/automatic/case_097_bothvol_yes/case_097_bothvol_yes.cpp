#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 097 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - one, two or three levels of indirection
//   Sink   (write): VOLATILE - one, two or three levels of indirection
// Idea:
//   A three level pointer chain where write and read independently pick
//   the level they go through. All nine combinations denote the same
//   address, so the volatility is entirely in the identity of the two
//   instructions.
// Expected result:
//   VOLATILE. Several of the nine level combinations are expected to be
//   missing under sampling.
// ============================================================

int main() {
    int cell = 0;
    int* level1 = &cell;
    int** level2 = &level1;
    int*** level3 = &level2;

    switch (rand() % 3) {
        case 0: *level1 = 11; break;        // Sink (level 1)
        case 1: **level2 = 12; break;       // Sink (level 2)
        default: ***level3 = 13; break;     // Sink (level 3)
    }

    int consumed = 0;
    switch (rand() % 3) {
        case 0: consumed = *level1; break;      // Source (level 1)
        case 1: consumed = **level2; break;     // Source (level 2)
        default: consumed = ***level3; break;   // Source (level 3)
    }
    (void) consumed;
}
