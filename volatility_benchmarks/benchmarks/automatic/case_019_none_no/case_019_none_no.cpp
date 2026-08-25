#include <stdio.h>

// ============================================================
// Case 019 - Volatility split 1: no volatility
//   Source (read) : stable  - one read of the copied field
//   Sink   (write): stable  - the struct assignment that produced it
// Idea:
//   Whole-struct assignment writes several fields with one statement,
//   then one field is read back. The sink is a single instruction that
//   covers multiple addresses; the source is a single instruction too.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH.
// ============================================================

struct Vec3 {
    int x;
    int y;
    int z;
};

int main() {
    Vec3 source_vec;
    source_vec.x = 1;
    source_vec.y = 2;
    source_vec.z = 3;

    Vec3 target_vec;
    target_vec = source_vec;        // Sink
    int value = target_vec.y;       // Source
    (void) value;
}
