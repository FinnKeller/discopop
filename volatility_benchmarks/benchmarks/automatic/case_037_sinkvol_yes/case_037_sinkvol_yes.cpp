#include <stdio.h>

// ============================================================
// Case 037 - Volatility split 2: sink volatile only
//   Source (read) : stable   - one read in main
//   Sink   (write): VOLATILE - a frequent and a rare writer function
// Idea:
//   Two writer functions, but the second one is only called on a few
//   ticks. Combines the cross-function sink with deterministic rarity,
//   which is a much sharper test than a fifty-fifty random choice.
// Expected result:
//   VOLATILE. The rare writer's line is expected to be lost for at least
//   one batch size while the frequent writer survives.
// ============================================================

void frequent_writer(int* target) {
    *target = 10;               // Sink (frequent)
}

void rare_writer(int* target) {
    *target = 20;               // Sink (rare)
}

int main() {
    static int tick = 0;
    int a = 0;

    if (tick % 43 == 13) {
        rare_writer(&a);
    } else {
        frequent_writer(&a);
    }

    int x = a;                  // Source
    tick = tick + 1;
    (void) x;
}
