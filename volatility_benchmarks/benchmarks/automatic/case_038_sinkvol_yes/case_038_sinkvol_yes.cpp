#include <stdio.h>

// ============================================================
// Case 038 - Volatility split 2: sink volatile only
//   Source (read) : stable   - one read in main
//   Sink   (write): VOLATILE - one of three writers behind a dispatcher
// Idea:
//   Two levels of calls: main calls a dispatcher, the dispatcher selects
//   one of three writers. The sink is therefore two frames away from the
//   read, which stresses the call-site bookkeeping in addition to the
//   sampling windows.
// Expected result:
//   VOLATILE. At least one of the three writer lines is expected to
//   disappear under sampling.
// ============================================================

void writer_one(int* target)   { *target = 101; }   // Sink (one)
void writer_two(int* target)   { *target = 102; }   // Sink (two)
void writer_three(int* target) { *target = 103; }   // Sink (three)

void dispatch(int* target, int selector) {
    if (selector == 0) {
        writer_one(target);
    } else if (selector == 1) {
        writer_two(target);
    } else {
        writer_three(target);
    }
}

int main() {
    static int tick = 0;
    int a = 0;
    dispatch(&a, tick % 3);
    int x = a;                  // Source
    tick = tick + 1;
    (void) x;
}
