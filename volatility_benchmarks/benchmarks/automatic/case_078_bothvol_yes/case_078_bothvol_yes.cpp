#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 078 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - one of three read instructions
//   Sink   (write): VOLATILE - one of three initialisation instructions
// Idea:
//   A pointer table selects which of three scalars is observed, so the
//   sink is one of three initialisations, and a second random choice
//   selects which of three instructions reads through the pointer. Both
//   ends move independently over the same pointer.
// Expected result:
//   VOLATILE. Several of the nine possible edges are expected to be
//   missing under sampling.
// ============================================================

int main() {
    int first = 11;                     // Sink (candidate 0)
    int second = 22;                    // Sink (candidate 1)
    int third = 33;                     // Sink (candidate 2)

    int* table[3] = { &first, &second, &third };
    int* selected = table[rand() % 3];

    int consumed = 0;
    switch (rand() % 3) {
        case 0: consumed = *selected; break;            // Source (read 0)
        case 1: consumed = *selected + 1; break;        // Source (read 1)
        default: consumed = *selected * 2; break;       // Source (read 2)
    }
    (void) consumed;
}
