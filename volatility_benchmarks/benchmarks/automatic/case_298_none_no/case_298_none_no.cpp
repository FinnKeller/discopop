#include <stdlib.h>

// ==========================================================
// Case 298 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a local pointer
//   Sink   (write): stable  - an assignment reached through a randomly indexed table whose slots are all the same function
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a stack array element reached by
//   pointer arithmetic. The write is an assignment reached through a
//   randomly indexed table whose slots are all the same function and
//   the read is a read through a local pointer.  Nothing in the
//   program can make a different instruction take either end of the
//   dependency, so the reported dependency structure cannot depend on
//   which accesses a sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_value(short* target) {
    *target = 33;        // Sink
}

int main() {
    short arr[16];
    short* cursor = arr + 5;
    void (*sink_table[4])(short*) = { store_value, store_value, store_value, store_value };
    sink_table[rand() % 4](cursor);
    const short* src_ptr = cursor;
    short observed = *src_ptr;        // Source
    (void) observed;
}
