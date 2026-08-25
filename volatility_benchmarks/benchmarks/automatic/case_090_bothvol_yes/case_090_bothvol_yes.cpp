#include <stdio.h>

// ============================================================
// Case 090 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - one read instruction per recursion parity
//   Sink   (write): VOLATILE - one write instruction per recursion parity
// Idea:
//   A single recursive function writes and reads the accumulator cell,
//   using different instructions depending on the parity of the current
//   depth. The starting depth rotates per tick, so both the last writer
//   and the first reader of the cell change between repetitions.
// Expected result:
//   VOLATILE. At least one parity combination is expected to be missing
//   from the sampled dependency set.
// ============================================================

static void walk(int* cell, int depth) {
    if (depth % 2 == 0) {
        *cell = depth;                  // Sink (even depth)
    } else {
        *cell = depth + 50;             // Sink (odd depth)
    }

    if (depth > 0) {
        walk(cell, depth - 1);
    }

    if (depth % 2 == 0) {
        int local = *cell;              // Source (even depth)
        (void) local;
    } else {
        int local = *cell + 1;          // Source (odd depth)
        (void) local;
    }
}

int main() {
    static int tick = 0;
    int cell = 0;
    walk(&cell, tick % 6);
    tick = tick + 1;
    (void) cell;
}
