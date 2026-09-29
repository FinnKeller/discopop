// ==========================================================
// Case 189 - Volatility split 1: no volatility
//   Source (read) : stable  - a plain read
//   Sink   (write): stable  - an assignment through a local pointer
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a heap cell whose address moves
//   every repetition. The write is an assignment through a local
//   pointer and the read is a plain read. Added noise: a second,
//   completely separate write/read pair on an unrelated variable.
//   Nothing in the program can make a different instruction take
//   either end of the dependency, so the reported dependency structure
//   cannot depend on which accesses a sampling window happens to
//   catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

int main() {
    long* cell = new long(0);
    int companion = 0;
    companion = 271;
    int companion_seen = companion;
    (void) companion_seen;
    long* sink_ptr = cell;
    *sink_ptr = 31;        // Sink
    long observed = *cell;        // Source
    (void) observed;
}
