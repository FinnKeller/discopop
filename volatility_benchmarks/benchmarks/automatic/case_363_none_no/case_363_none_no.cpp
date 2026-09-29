// ==========================================================
// Case 363 - Volatility split 1: no volatility
//   Source (read) : stable  - a read reached through a function pointer with a single target
//   Sink   (write): stable  - an assignment through a three hop pointer chain
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over one element of a stack array. The
//   write is an assignment through a three hop pointer chain and the
//   read is a read reached through a function pointer with a single
//   target.  Nothing in the program can make a different instruction
//   take either end of the dependency, so the reported dependency
//   structure cannot depend on which accesses a sampling window
//   happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static unsigned int load_value(const unsigned int* source) {
    return *source;        // Source
}

int main() {
    unsigned int arr[16];
    unsigned int* hop_a = &arr[7];
    unsigned int* hop_b = hop_a;
    unsigned int* hop_c = hop_b;
    *hop_c = 33;        // Sink
    unsigned int (*src_fp)(const unsigned int*) = load_value;
    unsigned int observed = src_fp(&arr[7]);
    (void) observed;
}
