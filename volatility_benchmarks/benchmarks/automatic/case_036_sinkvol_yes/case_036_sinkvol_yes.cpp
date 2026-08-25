#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 036 - Volatility split 2: sink volatile only
//   Source (read) : stable   - one read in main
//   Sink   (write): VOLATILE - one of four writer functions
// Idea:
//   A function pointer table with four writers, selected at random. Each
//   writer contains its own write instruction, so the callee identity
//   decides the sink line. Four candidates dilute each edge to a quarter
//   of the repetitions.
// Expected result:
//   VOLATILE. At least one writer's line is expected to be missing from
//   the sampled dependency set.
// ============================================================

void write_alpha(int* target) { *target = 1; }      // Sink (alpha)
void write_beta(int* target)  { *target = 2; }      // Sink (beta)
void write_gamma(int* target) { *target = 3; }      // Sink (gamma)
void write_delta(int* target) { *target = 4; }      // Sink (delta)

int main() {
    int a = 0;
    void (*table[4])(int*) = { write_alpha, write_beta, write_gamma, write_delta };
    table[rand() % 4](&a);
    int x = a;                                      // Source
    (void) x;
}
