#include <stdio.h>

// ============================================================
// Case 074 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - one read per hand written dispatch entry
//   Sink   (write): stable   - one write instruction in main
// Idea:
//   A structure holds a function pointer, forming a hand written virtual
//   table for readers. The selected entry decides which instruction
//   observes the value, so the source follows the data rather than the
//   control flow.
// Expected result:
//   VOLATILE. At least one of the three reader instructions is expected
//   to be lost from the sampled dependency set.
// ============================================================

struct Accessor {
    int tag;
    int (*load)(const int*);
};

static int load_plain(const int* source)  { return *source; }       // Source (plain)
static int load_double(const int* source) { return *source * 2; }   // Source (double)
static int load_offset(const int* source) { return *source + 7; }   // Source (offset)

int main() {
    static int tick = 0;

    Accessor accessors[3];
    accessors[0].tag = 0; accessors[0].load = load_plain;
    accessors[1].tag = 1; accessors[1].load = load_double;
    accessors[2].tag = 2; accessors[2].load = load_offset;

    int a = 0;
    a = 74;                                                         // Sink
    int x = accessors[tick % 3].load(&a);
    tick = tick + 1;
    (void) x;
}
