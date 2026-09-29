// ==========================================================
// Case 296 - Volatility split 1: no volatility
//   Source (read) : stable  - a plain read
//   Sink   (write): stable  - an assignment through a local pointer
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a function local static scalar.
//   The write is an assignment through a local pointer and the read is
//   a plain read.  Nothing in the program can make a different
//   instruction take either end of the dependency, so the reported
//   dependency structure cannot depend on which accesses a sampling
//   window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

int main() {
    static unsigned int cell;
    cell = 0;
    unsigned int* sink_ptr = &cell;
    *sink_ptr = 25;        // Sink
    unsigned int observed = cell;        // Source
    (void) observed;
}
