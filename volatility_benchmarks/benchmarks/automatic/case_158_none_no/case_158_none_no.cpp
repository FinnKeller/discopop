#include <stdlib.h>

// ==========================================================
// Case 158 - Volatility split 1: no volatility
//   Source (read) : stable  - a read reached through a function pointer with a single target
//   Sink   (write): stable  - an assignment reached through a function pointer with a single target
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a stack array element whose index
//   is drawn once and shared by both ends. The write is an assignment
//   reached through a function pointer with a single target and the
//   read is a read reached through a function pointer with a single
//   target. Added noise: a second, completely separate write/read pair
//   on an unrelated variable. Nothing in the program can make a
//   different instruction take either end of the dependency, so the
//   reported dependency structure cannot depend on which accesses a
//   sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_value(int* target) {
    *target = 42;        // Sink
}

static int load_value(const int* source) {
    return *source;        // Source
}

int main() {
    int arr[16];
    int idx = rand() % 16;
    int companion = 0;
    companion = 271;
    int companion_seen = companion;
    (void) companion_seen;
    void (*sink_fp)(int*) = store_value;
    sink_fp(&arr[idx]);
    int (*src_fp)(const int*) = load_value;
    int observed = src_fp(&arr[idx]);
    (void) observed;
}
