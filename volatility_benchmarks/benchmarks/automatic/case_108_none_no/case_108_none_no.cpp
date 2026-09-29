// ==========================================================
// Case 108 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a local pointer
//   Sink   (write): stable  - an assignment reached through a function pointer with a single target
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a plain stack scalar. The write is
//   an assignment reached through a function pointer with a single
//   target and the read is a read through a local pointer. Added
//   noise: a second, completely separate write/read pair on an
//   unrelated variable. Nothing in the program can make a different
//   instruction take either end of the dependency, so the reported
//   dependency structure cannot depend on which accesses a sampling
//   window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_value(unsigned int* target) {
    *target = 32;        // Sink
}

int main() {
    unsigned int cell = 0;
    int companion = 0;
    companion = 271;
    int companion_seen = companion;
    (void) companion_seen;
    void (*sink_fp)(unsigned int*) = store_value;
    sink_fp(&cell);
    const unsigned int* src_ptr = &cell;
    unsigned int observed = *src_ptr;        // Source
    (void) observed;
}
