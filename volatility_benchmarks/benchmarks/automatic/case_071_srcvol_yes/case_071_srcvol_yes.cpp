#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 071 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - one read instruction per derived class
//   Sink   (write): stable   - one write instruction in main
// Idea:
//   Virtual dispatch on the reading side. The dynamic type decides which
//   override observes the value, so the source instruction is only known
//   at run time even though the call site is unique.
// Expected result:
//   VOLATILE. One of the two override read instructions is expected to
//   be missing from the sampled dependency set.
// ============================================================

struct Reader {
    virtual int load(const int* source) = 0;
    virtual ~Reader() {}
};

struct PlainReader : Reader {
    int load(const int* source) { return *source; }         // Source (plain)
};

struct ScaledReader : Reader {
    int load(const int* source) { return *source * 3; }     // Source (scaled)
};

int main() {
    int a = 0;
    a = 71;                                                 // Sink

    PlainReader plain;
    ScaledReader scaled;
    Reader* selected = 0;
    if (rand() % 2 == 0) {
        selected = &plain;
    } else {
        selected = &scaled;
    }

    int x = selected->load(&a);
    (void) x;
}
