#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 067 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - one of three field read instructions
//   Sink   (write): stable   - one write instruction for the field
// Idea:
//   An array of records is written by a single instruction, and the field
//   of the selected record is read back by one of three instructions.
//   Structure member offsets keep the addressing non-trivial.
// Expected result:
//   VOLATILE. At least one of the three read instructions is expected to
//   be missing under sampling.
// ============================================================

struct Entry {
    int key;
    int value;
};

int main() {
    Entry entries[4];
    for (int i = 0; i < 4; ++i) {
        entries[i].key = i;
        entries[i].value = 0;
    }

    int index = rand() % 4;
    entries[index].value = 67;              // Sink

    int consumed = 0;
    int mode = rand() % 3;
    if (mode == 0) {
        consumed = entries[index].value;            // Source (mode 0)
    } else if (mode == 1) {
        consumed = entries[index].value + 1;        // Source (mode 1)
    } else {
        consumed = entries[index].value * 2;        // Source (mode 2)
    }
    (void) consumed;
}
