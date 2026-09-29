// ==========================================================
// Case 232 - Volatility split 1: no volatility
//   Source (read) : stable  - a plain read
//   Sink   (write): stable  - an assignment through a three hop pointer chain
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a function local static scalar.
//   The write is an assignment through a three hop pointer chain and
//   the read is a plain read. Added noise: a second, completely
//   separate write/read pair on an unrelated variable. Nothing in the
//   program can make a different instruction take either end of the
//   dependency, so the reported dependency structure cannot depend on
//   which accesses a sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

int main() {
    static unsigned int cell;
    cell = 0;
    int companion = 0;
    companion = 271;
    int companion_seen = companion;
    (void) companion_seen;
    unsigned int* hop_a = &cell;
    unsigned int* hop_b = hop_a;
    unsigned int* hop_c = hop_b;
    *hop_c = 29;        // Sink
    unsigned int observed = cell;        // Source
    (void) observed;
}
