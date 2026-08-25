#include <stdio.h>

// ============================================================
// Case 050 - Volatility split 2: sink volatile only
//   Source (read) : stable   - one read in main
//   Sink   (write): VOLATILE - rare virtual override plus padding distance
// Idea:
//   The strongest sink volatile construction in this set: virtual
//   dispatch chooses between a frequent and a rare writer, and the read
//   is additionally separated from the write by padding accesses. Both
//   levers - rarity of the variant and shadow memory clearing across the
//   distance - attack the sink end at the same time.
// Expected result:
//   VOLATILE for every batch size, with the rare override expected to be
//   the first edge to vanish.
// ============================================================

static int scratch[32];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 32; ++i) {
            scratch[i] = r * i;
        }
    }
}

struct Base {
    virtual void store(int* target) = 0;
    virtual ~Base() {}
};

struct CommonImpl : Base {
    void store(int* target) { *target = 81; }        // Sink (frequent)
};

struct RareImpl : Base {
    void store(int* target) { *target = 82; }        // Sink (rare)
};

int main() {
    static int tick = 0;

    int a = 0;
    CommonImpl common;
    RareImpl rare;
    Base* selected = &common;
    if (tick % 31 == 17) {
        selected = &rare;
    }

    selected->store(&a);
    pad_writes(80);
    int x = a;                                      // Source
    tick = tick + 1;
    (void) x;
}
