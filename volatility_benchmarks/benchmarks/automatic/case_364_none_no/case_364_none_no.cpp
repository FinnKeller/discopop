// ==========================================================
// Case 364 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a const reference parameter
//   Sink   (write): stable  - an assignment through a reference parameter
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a heap cell whose address moves
//   every repetition. The write is an assignment through a reference
//   parameter and the read is a read through a const reference
//   parameter. Added noise: a second, completely separate write/read
//   pair on an unrelated variable. Nothing in the program can make a
//   different instruction take either end of the dependency, so the
//   reported dependency structure cannot depend on which accesses a
//   sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_ref(unsigned int& target) {
    target = 39;        // Sink
}

static unsigned int load_ref(const unsigned int& source) {
    return source;        // Source
}

int main() {
    unsigned int* cell = new unsigned int(0);
    int companion = 0;
    companion = 271;
    int companion_seen = companion;
    (void) companion_seen;
    store_ref(*cell);
    unsigned int observed = load_ref(*cell);
    (void) observed;
}
