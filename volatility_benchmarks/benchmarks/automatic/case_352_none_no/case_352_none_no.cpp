// ==========================================================
// Case 352 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a local pointer
//   Sink   (write): stable  - an assignment through a three hop pointer chain
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a function local static scalar.
//   The write is an assignment through a three hop pointer chain and
//   the read is a read through a local pointer. Added noise: a dead
//   store to an unrelated variable. Nothing in the program can make a
//   different instruction take either end of the dependency, so the
//   reported dependency structure cannot depend on which accesses a
//   sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

int main() {
    static char cell;
    cell = 0;
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    char* hop_a = &cell;
    char* hop_b = hop_a;
    char* hop_c = hop_b;
    *hop_c = 31;        // Sink
    const char* src_ptr = &cell;
    char observed = *src_ptr;        // Source
    (void) observed;
}
