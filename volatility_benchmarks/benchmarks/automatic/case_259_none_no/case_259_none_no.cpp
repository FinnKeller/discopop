// ==========================================================
// Case 259 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a const reference parameter
//   Sink   (write): stable  - an assignment through a three hop pointer chain
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a heap cell allocated and released
//   per repetition. The write is an assignment through a three hop
//   pointer chain and the read is a read through a const reference
//   parameter.  Nothing in the program can make a different
//   instruction take either end of the dependency, so the reported
//   dependency structure cannot depend on which accesses a sampling
//   window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static unsigned int load_ref(const unsigned int& source) {
    return source;        // Source
}

int main() {
    unsigned int* cell = new unsigned int(0);
    unsigned int* hop_a = cell;
    unsigned int* hop_b = hop_a;
    unsigned int* hop_c = hop_b;
    *hop_c = 33;        // Sink
    unsigned int observed = load_ref(*cell);
    (void) observed;
    delete cell;
}
