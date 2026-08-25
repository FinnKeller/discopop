#include <stdio.h>

// ============================================================
// Case 009 - Volatility split 1: no volatility
//   Source (read) : stable  - the accumulator read in the reduction
//   Sink   (write): stable  - the accumulator write in the reduction
// Idea:
//   A loop-carried dependency on the accumulator: the write of iteration
//   i is the source of the read in iteration i+1. Source and sink are
//   the same statement, so the reported edge is a fixed self-dependency
//   no matter how many iterations sampling hides.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH.
// ============================================================

int main() {
    int data[16];
    for (int i = 0; i < 16; ++i) {
        data[i] = i * 2;
    }
    int acc = 0;
    for (int i = 0; i < 16; ++i) {
        acc = acc + data[i];        // Sink and Source (loop carried)
    }
    (void) acc;
}
