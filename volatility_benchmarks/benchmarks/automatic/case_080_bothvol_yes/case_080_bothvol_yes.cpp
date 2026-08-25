#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 080 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - one of two read instructions
//   Sink   (write): VOLATILE - one of two write instructions, record erased
// Idea:
//   Endpoint ambiguity on both sides plus the distance lever: 2560
//   padding writes separate the write from the read, which is more than
//   the largest sampling batch, so a shadow memory clear is guaranteed
//   in between. Ambiguity decides *which* edge exists, the distance
//   decides *whether* it can be observed at all.
// Expected result:
//   VOLATILE for every batch size.
// ============================================================

static int scratch[64];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
            scratch[i] = r + i;
        }
    }
}

int main() {
    int shared = 0;

    if (rand() % 2 == 0) {
        shared = 5;                     // Sink (variant 0)
    } else {
        shared = 6;                     // Sink (variant 1)
    }

    pad_writes(40);

    int consumed = 0;
    if (rand() % 2 == 0) {
        consumed = shared;              // Source (variant 0)
    } else {
        consumed = shared * 2;          // Source (variant 1)
    }
    (void) consumed;
}
