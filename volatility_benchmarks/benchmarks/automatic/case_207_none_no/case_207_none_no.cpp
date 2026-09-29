// ==========================================================
// Case 207 - Volatility split 1: no volatility
//   Source (read) : stable  - a plain read
//   Sink   (write): stable  - an assignment through a three hop pointer chain
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a translation unit global scalar.
//   The write is an assignment through a three hop pointer chain and
//   the read is a plain read.  Nothing in the program can make a
//   different instruction take either end of the dependency, so the
//   reported dependency structure cannot depend on which accesses a
//   sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static unsigned int g_cell;

int main() {
    g_cell = 0;
    unsigned int* hop_a = &g_cell;
    unsigned int* hop_b = hop_a;
    unsigned int* hop_c = hop_b;
    *hop_c = 27;        // Sink
    unsigned int observed = g_cell;        // Source
    (void) observed;
}
