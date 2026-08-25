#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 022 - Volatility split 1: no volatility
//   Source (read) : stable  - one read site
//   Sink   (write): stable  - one write site, single possible target
// Idea:
//   A pointer table indexed by a random value, exactly like the classic
//   sink-volatile pattern, except that every table slot points to the
//   same variable. The runtime choice is real but irrelevant: the chosen
//   pointer always denotes the same address, written by one instruction.
//   Deliberate false-positive trap for volatility detection.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH.
// ============================================================

int main() {
    int target = 0;
    int* table[4] = { &target, &target, &target, &target };

    int* selected = table[rand() % 4];
    *selected = 17;             // Sink
    int x = *selected;          // Source
    (void) x;
}
