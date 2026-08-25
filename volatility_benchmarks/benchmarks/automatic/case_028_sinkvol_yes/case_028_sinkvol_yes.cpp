#include <stdio.h>

// ============================================================
// Case 028 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a single read instruction, always observed
//   Sink   (write): VOLATILE - a single write whose record is erased
// Idea:
//   Distance lever instead of endpoint ambiguity. The write and the read
//   of the observed variable are separated by 2560 padding writes. Since
//   that is more than the largest sampling batch, an on-to-off window
//   transition - and with it a full shadow memory clear - is guaranteed
//   to happen in between. The read then no longer knows its predecessor,
//   so the sink end of the dependency is destroyed for every repetition.
// Expected result:
//   VOLATILE for every batch size. This is the most deterministic
//   volatility mechanism in the set.
// ============================================================

static int scratch[64];

void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
            scratch[i] = r + i;
        }
    }
}

int main() {
    int observed = 0;
    observed = 5;               // Sink
    pad_writes(40);
    int x = observed;           // Source
    (void) x;
}
