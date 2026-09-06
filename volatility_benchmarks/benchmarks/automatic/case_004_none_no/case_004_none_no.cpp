#include <stdio.h>

// ============================================================
// Case 004 - Volatility split 1: no volatility
//   Source (read) : stable  - one read of one field
//   Sink   (write): stable  - one write of the same field
// Idea:
//   Structure field access through a pointer to the struct. The field
//   offset is a compile-time constant, so the written and the read
//   address are always the same and both instructions are unique.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH.
// ============================================================

struct Pair {
    int first;
    int second;
};

int main() {
    Pair pair;
    Pair* ptr = &pair;
    ptr->second = 9;        // Sink
    int x = ptr->second;    // Source
    (void) x;
}
