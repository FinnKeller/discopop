#include <stdio.h>

// ============================================================
// Case 075 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - rare virtual override plus phase shifting
//   Sink   (write): stable   - one write instruction in main
// Idea:
//   The strongest source volatile construction in this set. Virtual
//   dispatch chooses between a frequent and a rare reader, and padding
//   reads placed *before* the write shift the sampling window phase from
//   repetition to repetition. The padding deliberately stays in front of
//   the write so that no shadow memory clear can fall between write and
//   read - only the source end is attacked.
// Expected result:
//   VOLATILE. The rare override read instruction is expected to be the
//   first key to vanish.
// ============================================================

static int scratch[32];

static int pad_reads(int rounds) {
    int sum = 0;
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 32; ++i) {
            sum += scratch[i];
        }
    }
    return sum;
}

struct Observer {
    virtual int observe(const int* source) = 0;
    virtual ~Observer() {}
};

struct CommonObserver : Observer {
    int observe(const int* source) { return *source + 1; }       // Source (frequent)
};

struct RareObserver : Observer {
    int observe(const int* source) { return *source + 2; }       // Source (rare)
};

int main() {
    static int tick = 0;

    int noise = pad_reads(37 + (tick % 5));

    int a = 0;
    a = 75;                                                     // Sink

    CommonObserver common;
    RareObserver rare;
    Observer* selected = &common;
    if (tick % 29 == 19) {
        selected = &rare;
    }

    int x = selected->observe(&a);
    tick = tick + 1;
    (void) x;
    (void) noise;
}
