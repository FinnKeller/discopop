#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 061 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - one of four reader functions
//   Sink   (write): stable   - one write instruction in main
// Idea:
//   A function pointer table of four readers. The write stays in main and
//   is unique, so only the callee that performs the read changes. The
//   dependency crosses a call boundary on the source side.
// Expected result:
//   VOLATILE. At least one reader function's instruction is expected to
//   be missing from the sampled dependency set.
// ============================================================

int read_alpha(const int* source) { return *source + 1; }       // Source (alpha)
int read_beta(const int* source)  { return *source + 2; }       // Source (beta)
int read_gamma(const int* source) { return *source + 3; }       // Source (gamma)
int read_delta(const int* source) { return *source + 4; }       // Source (delta)

int main() {
    int a = 0;
    a = 61;                                                     // Sink

    int (*table[4])(const int*) = { read_alpha, read_beta, read_gamma, read_delta };
    int x = table[rand() % 4](&a);
    (void) x;
}
