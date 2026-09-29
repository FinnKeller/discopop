#include <stdlib.h>

// ==========================================================
// Case 134 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a lambda
//   Sink   (write): stable  - an assignment inside a writer function
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a field of a heap struct. The
//   write is an assignment inside a writer function and the read is a
//   read inside a lambda. Added noise: a random branch that only ever
//   touches an unrelated scratch variable. Nothing in the program can
//   make a different instruction take either end of the dependency, so
//   the reported dependency structure cannot depend on which accesses
//   a sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

struct Box { char guard; char payload; };

static void store_value(char* target) {
    *target = 41;        // Sink
}

int main() {
    Box* box = new Box;
    box->guard = 0;
    int scratch = 0;
    if (rand() % 2 == 0) { scratch = 1; } else { scratch = 2; }
    (void) scratch;
    store_value(&box->payload);
    auto src_lambda = [](const char* source) { return *source; };        // Source
    char observed = src_lambda(&box->payload);
    (void) observed;
}
