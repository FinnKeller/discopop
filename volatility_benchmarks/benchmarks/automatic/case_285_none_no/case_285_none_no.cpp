// ==========================================================
// Case 285 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a function template instance
//   Sink   (write): stable  - a plain assignment
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a heap cell allocated and released
//   per repetition. The write is a plain assignment and the read is a
//   read inside a function template instance.  Nothing in the program
//   can make a different instruction take either end of the
//   dependency, so the reported dependency structure cannot depend on
//   which accesses a sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

template <typename V>
static V load_generic(const V* source) {
    return *source;        // Source
}

int main() {
    unsigned int* cell = new unsigned int(0);
    *cell = 34;        // Sink
    unsigned int observed = load_generic<unsigned int>(cell);
    (void) observed;
    delete cell;
}
