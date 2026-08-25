#include <stdio.h>

// ============================================================
// Case 040 - Volatility split 2: sink volatile only
//   Source (read) : stable   - one read in main
//   Sink   (write): VOLATILE - even or odd recursion frame writes last
// Idea:
//   Two mutually recursive functions, each with its own write. The
//   recursion depth varies per tick, so whether the even or the odd
//   function performs the final write - and thus which line the read
//   depends on - changes at runtime.
// Expected result:
//   VOLATILE. One of the two recursion write lines is expected to drop
//   out of the sampled dependency set.
// ============================================================

void odd_step(int* target, int depth);

void even_step(int* target, int depth) {
    *target = depth;                // Sink (even frame)
    if (depth > 0) {
        odd_step(target, depth - 1);
    }
}

void odd_step(int* target, int depth) {
    *target = depth + 100;          // Sink (odd frame)
    if (depth > 0) {
        even_step(target, depth - 1);
    }
}

int main() {
    static int tick = 0;
    int a = 0;
    even_step(&a, tick % 5);
    int x = a;                      // Source
    tick = tick + 1;
    (void) x;
}
