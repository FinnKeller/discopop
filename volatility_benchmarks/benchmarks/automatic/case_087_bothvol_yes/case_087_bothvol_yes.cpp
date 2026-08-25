#include <stdio.h>

// ============================================================
// Case 087 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a frequent and a rare reader function
//   Sink   (write): VOLATILE - a frequent and a rare writer function
// Idea:
//   Cross-procedural rarity on both ends with coprime periods, so all
//   four combinations occur but with wildly different frequencies. The
//   rare/rare edge is expected to occur at most once in a hundred
//   repetitions.
// Expected result:
//   VOLATILE. Every edge involving a rare function is expected to be
//   lost for at least one batch size.
// ============================================================

static void frequent_store(int* target) { *target = 10; }           // Sink (frequent)
static void rare_store(int* target)     { *target = 20; }           // Sink (rare)

static int frequent_fetch(const int* source) { return *source + 1; }    // Source (frequent)
static int rare_fetch(const int* source)     { return *source + 2; }    // Source (rare)

int main() {
    static int tick = 0;
    int a = 0;

    if (tick % 17 == 3) {
        rare_store(&a);
    } else {
        frequent_store(&a);
    }

    int x = 0;
    if (tick % 13 == 5) {
        x = rare_fetch(&a);
    } else {
        x = frequent_fetch(&a);
    }

    tick = tick + 1;
    (void) x;
}
