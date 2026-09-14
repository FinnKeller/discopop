#include <stdlib.h>

// ==========================================================
// Case 120 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a lambda
//   Sink   (write): stable  - an assignment reached through a function pointer with a single target
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over the value member of a stack union.
//   The write is an assignment reached through a function pointer with
//   a single target and the read is a read inside a lambda. Added
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

union Slot { char as_value; unsigned char raw[sizeof(char)]; };

static void store_value(char* target) {
    *target = 45;        // Sink
}

int main() {
    Slot slot;
    int scratch = 0;
    if (rand() % 2 == 0) { scratch = 1; } else { scratch = 2; }
    (void) scratch;
    void (*sink_fp)(char*) = store_value;
    sink_fp(&slot.as_value);
    auto src_lambda = [](const char* source) { return *source; };        // Source
    char observed = src_lambda(&slot.as_value);
    (void) observed;
}
