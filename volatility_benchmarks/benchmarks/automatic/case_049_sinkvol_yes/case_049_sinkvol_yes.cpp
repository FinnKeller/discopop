#include <stdio.h>

// ============================================================
// Case 049 - Volatility split 2: sink volatile only
//   Source (read) : stable   - one read in main
//   Sink   (write): VOLATILE - one write per hand written dispatch entry
// Idea:
//   A structure holds a function pointer, which is a hand written
//   virtual table. The selected structure decides the writer, so the
//   sink line follows the data rather than the control flow.
// Expected result:
//   VOLATILE. At least one of the three writer lines is expected to be
//   missing under sampling.
// ============================================================

struct Handler {
    int tag;
    void (*store)(int*);
};

static void store_low(int* target)  { *target = 5; }        // Sink (low)
static void store_mid(int* target)  { *target = 6; }        // Sink (mid)
static void store_high(int* target) { *target = 7; }        // Sink (high)

int main() {
    static int tick = 0;

    Handler handlers[3];
    handlers[0].tag = 0; handlers[0].store = store_low;
    handlers[1].tag = 1; handlers[1].store = store_mid;
    handlers[2].tag = 2; handlers[2].store = store_high;

    int a = 0;
    handlers[tick % 3].store(&a);
    int x = a;                                              // Source
    tick = tick + 1;
    (void) x;
}
