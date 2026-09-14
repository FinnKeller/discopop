// ==========================================================
// Case 269 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a local pointer
//   Sink   (write): stable  - an assignment inside a writer function
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a heap cell allocated and released
//   per repetition. The write is an assignment inside a writer
//   function and the read is a read through a local pointer.  Nothing
//   in the program can make a different instruction take either end of
//   the dependency, so the reported dependency structure cannot depend
//   on which accesses a sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_value(int* target) {
    *target = 29;        // Sink
}

int main() {
    int* cell = new int(0);
    store_value(cell);
    const int* src_ptr = cell;
    int observed = *src_ptr;        // Source
    (void) observed;
    delete cell;
}
