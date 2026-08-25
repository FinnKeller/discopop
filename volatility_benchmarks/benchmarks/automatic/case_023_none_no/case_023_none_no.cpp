#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 023 - Volatility split 1: no volatility
//   Source (read) : stable  - one read site in main
//   Sink   (write): stable  - one write site, reached via every table slot
// Idea:
//   A function pointer table selected by a random index, but all slots
//   hold the same function. The indirect call target varies statically
//   and not dynamically, so the write instruction is unique.
//   Companion trap to case 022 on the call side.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH.
// ============================================================

void only_writer(int* target) {
    *target = 23;               // Sink
}

int main() {
    int a = 0;
    void (*table[3])(int*) = { only_writer, only_writer, only_writer };
    table[rand() % 3](&a);
    int x = a;                  // Source
    (void) x;
}
