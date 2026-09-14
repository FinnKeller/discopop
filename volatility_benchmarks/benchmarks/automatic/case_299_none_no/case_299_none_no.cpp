// ==========================================================
// Case 299 - Volatility split 1: no volatility
//   Source (read) : stable  - a plain read
//   Sink   (write): stable  - an assignment inside a writer function
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a field of a heap struct. The
//   write is an assignment inside a writer function and the read is a
//   plain read. Added noise: a dead store to an unrelated variable.
//   Nothing in the program can make a different instruction take
//   either end of the dependency, so the reported dependency structure
//   cannot depend on which accesses a sampling window happens to
//   catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

struct Box { unsigned int guard; unsigned int payload; };

static void store_value(unsigned int* target) {
    *target = 36;        // Sink
}

int main() {
    Box* box = new Box;
    box->guard = 0;
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    store_value(&box->payload);
    unsigned int observed = box->payload;        // Source
    (void) observed;
}
