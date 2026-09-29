#include <stdlib.h>

// ==========================================================
// Case 178 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a const reference parameter
//   Sink   (write): stable  - an assignment reached through a randomly indexed table whose slots are all the same function
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a stack array element reached by
//   pointer arithmetic. The write is an assignment reached through a
//   randomly indexed table whose slots are all the same function and
//   the read is a read through a const reference parameter. Added
//   noise: a random branch that only ever touches an unrelated scratch
//   variable. Nothing in the program can make a different instruction
//   take either end of the dependency, so the reported dependency
//   structure cannot depend on which accesses a sampling window
//   happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_value(char* target) {
    *target = 39;        // Sink
}

static char load_ref(const char& source) {
    return source;        // Source
}

int main() {
    char arr[16];
    char* cursor = arr + 5;
    int scratch = 0;
    if (rand() % 2 == 0) { scratch = 1; } else { scratch = 2; }
    (void) scratch;
    void (*sink_table[4])(char*) = { store_value, store_value, store_value, store_value };
    sink_table[rand() % 4](cursor);
    char observed = load_ref(*cursor);
    (void) observed;
}
