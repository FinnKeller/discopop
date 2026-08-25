#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 094 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - one read instruction per tree leaf
//   Sink   (write): VOLATILE - one write instruction per tree leaf
// Idea:
//   A binary tree is walked by a random path. Each leaf has its own write
//   instruction and its own read instruction, so both ends of the edge
//   are determined by the path. Four correlated edges out of sixteen
//   possible instruction pairs.
// Expected result:
//   VOLATILE. At least one leaf edge is expected to be missing from the
//   sampled dependency set.
// ============================================================

struct Branch {
    int value;
    Branch* left;
    Branch* right;
};

int main() {
    Branch l00; l00.left = 0; l00.right = 0; l00.value = 0;
    Branch l01; l01.left = 0; l01.right = 0; l01.value = 0;
    Branch l10; l10.left = 0; l10.right = 0; l10.value = 0;
    Branch l11; l11.left = 0; l11.right = 0; l11.value = 0;

    int first = rand() % 2;
    int second = rand() % 2;
    int consumed = 0;

    if (first == 0 && second == 0) {
        l00.value = 1;              // Sink (leaf 00)
        consumed = l00.value;       // Source (leaf 00)
    } else if (first == 0) {
        l01.value = 2;              // Sink (leaf 01)
        consumed = l01.value;       // Source (leaf 01)
    } else if (second == 0) {
        l10.value = 3;              // Sink (leaf 10)
        consumed = l10.value;       // Source (leaf 10)
    } else {
        l11.value = 4;              // Sink (leaf 11)
        consumed = l11.value;       // Source (leaf 11)
    }
    (void) consumed;
}
