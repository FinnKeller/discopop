#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 092 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - one of two field read instructions
//   Sink   (write): VOLATILE - one of two field write instructions
// Idea:
//   An array of records with two candidate write instructions and two
//   candidate read instructions for the same field of the same selected
//   record. Structure offsets plus a random record index keep the address
//   computation non-trivial.
// Expected result:
//   VOLATILE. At least one of the four combinations is expected to be
//   missing from the sampled dependency set.
// ============================================================

struct Cell {
    int tag;
    int payload;
};

int main() {
    Cell cells[6];
    for (int i = 0; i < 6; ++i) {
        cells[i].tag = i;
        cells[i].payload = 0;
    }

    int index = rand() % 6;
    Cell* selected = &cells[index];

    if (rand() % 2 == 0) {
        cells[index].payload = 21;          // Sink (subscript form)
    } else {
        selected->payload = 22;             // Sink (pointer form)
    }

    int consumed = 0;
    if (rand() % 2 == 0) {
        consumed = cells[index].payload;    // Source (subscript form)
    } else {
        consumed = selected->payload;       // Source (pointer form)
    }
    (void) consumed;
}
