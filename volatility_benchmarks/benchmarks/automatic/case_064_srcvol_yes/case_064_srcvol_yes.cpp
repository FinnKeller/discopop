#include <stdio.h>

// ============================================================
// Case 064 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - one of three readers behind a dispatcher
//   Sink   (write): stable   - one write instruction in main
// Idea:
//   The read is two call frames away from the write: main calls a
//   dispatcher which forwards to one of three readers. This stresses the
//   call-site bookkeeping on the source side while the sink is fixed.
// Expected result:
//   VOLATILE. At least one of the three reader instructions is expected
//   to disappear under sampling.
// ============================================================

int reader_one(const int* source)   { return *source + 1; }     // Source (one)
int reader_two(const int* source)   { return *source + 2; }     // Source (two)
int reader_three(const int* source) { return *source + 3; }     // Source (three)

int dispatch_read(const int* source, int selector) {
    if (selector == 0) {
        return reader_one(source);
    }
    if (selector == 1) {
        return reader_two(source);
    }
    return reader_three(source);
}

int main() {
    static int tick = 0;
    int a = 0;
    a = 64;                         // Sink
    int x = dispatch_read(&a, tick % 3);
    tick = tick + 1;
    (void) x;
}
