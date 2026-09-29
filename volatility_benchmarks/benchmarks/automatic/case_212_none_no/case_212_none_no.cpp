// ==========================================================
// Case 212 - Volatility split 1: no volatility
//   Source (read) : stable  - a plain read
//   Sink   (write): stable  - an assignment through a three hop pointer chain
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a translation unit global scalar.
//   The write is an assignment through a three hop pointer chain and
//   the read is a plain read. Added noise: a dead store to an
//   unrelated variable. Nothing in the program can make a different
//   instruction take either end of the dependency, so the reported
//   dependency structure cannot depend on which accesses a sampling
//   window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static long long g_cell;

int main() {
    g_cell = 0;
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    long long* hop_a = &g_cell;
    long long* hop_b = hop_a;
    long long* hop_c = hop_b;
    *hop_c = 30;        // Sink
    long long observed = g_cell;        // Source
    (void) observed;
}
