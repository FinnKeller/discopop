// ==========================================================
// Case 234 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a const reference parameter
//   Sink   (write): stable  - an assignment inside a writer function
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a heap cell whose address moves
//   every repetition. The write is an assignment inside a writer
//   function and the read is a read through a const reference
//   parameter. Added noise: a dead store to an unrelated variable.
//   Nothing in the program can make a different instruction take
//   either end of the dependency, so the reported dependency structure
//   cannot depend on which accesses a sampling window happens to
//   catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_value(int* target) {
    *target = 34;        // Sink
}

static int load_ref(const int& source) {
    return source;        // Source
}

int main() {
    int* cell = new int(0);
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    store_value(cell);
    int observed = load_ref(*cell);
    (void) observed;
}
