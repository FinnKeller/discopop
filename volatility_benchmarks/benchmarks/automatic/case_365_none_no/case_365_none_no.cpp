// ==========================================================
// Case 365 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a function template instance
//   Sink   (write): stable  - an assignment through a three hop pointer chain
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a plain stack scalar. The write is
//   an assignment through a three hop pointer chain and the read is a
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
    char cell = 0;
    char* hop_a = &cell;
    char* hop_b = hop_a;
    char* hop_c = hop_b;
    *hop_c = 33;        // Sink
    char observed = load_generic<char>(&cell);
    (void) observed;
}
