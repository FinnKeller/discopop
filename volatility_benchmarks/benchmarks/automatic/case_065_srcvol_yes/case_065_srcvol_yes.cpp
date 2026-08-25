#include <stdio.h>

// ============================================================
// Case 065 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - even or odd recursion frame reads first
//   Sink   (write): stable   - one write instruction in main
// Idea:
//   Two mutually recursive readers, each with its own read instruction.
//   The recursion depth changes per tick, so the set of frames - and
//   therefore the set of read instructions that observe the value -
//   varies at runtime.
// Expected result:
//   VOLATILE. One of the two recursion read instructions is expected to
//   be missing from the sampled dependency set.
// ============================================================

int odd_read(const int* source, int depth);

int even_read(const int* source, int depth) {
    int local = *source + depth;            // Source (even frame)
    if (depth > 0) {
        local += odd_read(source, depth - 1);
    }
    return local;
}

int odd_read(const int* source, int depth) {
    int local = *source - depth;            // Source (odd frame)
    if (depth > 0) {
        local += even_read(source, depth - 1);
    }
    return local;
}

int main() {
    static int tick = 0;
    int a = 0;
    a = 65;                                 // Sink
    int x = even_read(&a, tick % 4);
    tick = tick + 1;
    (void) x;
}
