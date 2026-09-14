// ==========================================================
// Case 173 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a const reference parameter
//   Sink   (write): stable  - a plain assignment
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a plain stack scalar. The write is
//   a plain assignment and the read is a read through a const
//   reference parameter.  Nothing in the program can make a different
//   instruction take either end of the dependency, so the reported
//   dependency structure cannot depend on which accesses a sampling
//   window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static long load_ref(const long& source) {
    return source;        // Source
}

int main() {
    long cell = 0;
    cell = 24;        // Sink
    long observed = load_ref(cell);
    (void) observed;
}
