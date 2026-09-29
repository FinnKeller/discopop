// ==========================================================
// Case 102 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a local pointer
//   Sink   (write): stable  - an assignment through a three hop pointer chain
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over one element of a stack array. The
//   write is an assignment through a three hop pointer chain and the
//   read is a read through a local pointer. Added noise: a dead store
//   to an unrelated variable. Nothing in the program can make a
//   different instruction take either end of the dependency, so the
//   reported dependency structure cannot depend on which accesses a
//   sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

int main() {
    int arr[16];
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    int* hop_a = &arr[7];
    int* hop_b = hop_a;
    int* hop_c = hop_b;
    *hop_c = 28;        // Sink
    const int* src_ptr = &arr[7];
    int observed = *src_ptr;        // Source
    (void) observed;
}
