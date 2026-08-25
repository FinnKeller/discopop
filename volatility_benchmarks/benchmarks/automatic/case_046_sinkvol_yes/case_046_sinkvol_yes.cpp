#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 046 - Volatility split 2: sink volatile only
//   Source (read) : stable   - one read in main
//   Sink   (write): VOLATILE - one write instruction per derived class
// Idea:
//   Virtual dispatch selects the writer. The dynamic type decides which
//   override performs the write, so the sink line is only known at run
//   time even though the call site is unique.
// Expected result:
//   VOLATILE. One of the two override write lines is expected to be
//   missing from the sampled dependency set.
// ============================================================

struct Writer {
    virtual void store(int* target) = 0;
    virtual ~Writer() {}
};

struct LowWriter : Writer {
    void store(int* target) { *target = 1; }        // Sink (low)
};

struct HighWriter : Writer {
    void store(int* target) { *target = 2; }        // Sink (high)
};

int main() {
    int a = 0;
    LowWriter low;
    HighWriter high;

    Writer* selected = 0;
    if (rand() % 2 == 0) {
        selected = &low;
    } else {
        selected = &high;
    }

    selected->store(&a);
    int x = a;                                      // Source
    (void) x;
}
