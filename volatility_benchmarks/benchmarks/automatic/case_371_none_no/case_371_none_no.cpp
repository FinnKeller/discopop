// ==========================================================
// Case 371 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a local pointer
//   Sink   (write): stable  - an assignment through a local pointer
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a plain stack scalar. The write is
//   an assignment through a local pointer and the read is a read
//   through a local pointer.  Nothing in the program can make a
//   different instruction take either end of the dependency, so the
//   reported dependency structure cannot depend on which accesses a
//   sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

int main() {
    long long cell = 0;
    long long* sink_ptr = &cell;
    *sink_ptr = 26;        // Sink
    const long long* src_ptr = &cell;
    long long observed = *src_ptr;        // Source
    (void) observed;
}
