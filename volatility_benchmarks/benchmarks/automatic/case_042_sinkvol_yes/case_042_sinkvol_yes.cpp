#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 042 - Volatility split 2: sink volatile only
//   Source (read) : stable   - one read of the selected record field
//   Sink   (write): VOLATILE - one of three field write instructions
// Idea:
//   An array of structures where the field of the selected record is
//   written by one of three instructions. Struct member offsets keep the
//   address computation non-trivial while the read stays unique.
// Expected result:
//   VOLATILE. At least one of the three write lines is expected to be
//   missing under sampling.
// ============================================================

struct Record {
    int key;
    int value;
};

int main() {
    Record records[4];
    for (int i = 0; i < 4; ++i) {
        records[i].key = i;
        records[i].value = 0;
    }

    int index = rand() % 4;
    int mode = rand() % 3;

    if (mode == 0) {
        records[index].value = 61;          // Sink (mode 0)
    } else if (mode == 1) {
        records[index].value = 62;          // Sink (mode 1)
    } else {
        records[index].value = 63;          // Sink (mode 2)
    }

    int x = records[index].value;           // Source
    (void) x;
}
