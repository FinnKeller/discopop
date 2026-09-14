// ==========================================================
// Case 261 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a local pointer
//   Sink   (write): stable  - an assignment through a local pointer
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a translation unit global scalar.
//   The write is an assignment through a local pointer and the read is
//   a read through a local pointer.  Nothing in the program can make a
//   different instruction take either end of the dependency, so the
//   reported dependency structure cannot depend on which accesses a
//   sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static int g_cell;

int main() {
    g_cell = 0;
    int* sink_ptr = &g_cell;
    *sink_ptr = 24;        // Sink
    const int* src_ptr = &g_cell;
    int observed = *src_ptr;        // Source
    (void) observed;
}
