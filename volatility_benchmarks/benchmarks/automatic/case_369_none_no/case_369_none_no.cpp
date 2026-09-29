// ==========================================================
// Case 369 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a local pointer
//   Sink   (write): stable  - an assignment two call levels down
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a field of a heap struct. The
//   write is an assignment two call levels down and the read is a read
//   through a local pointer. Added noise: a dead store to an unrelated
//   variable. Nothing in the program can make a different instruction
//   take either end of the dependency, so the reported dependency
//   structure cannot depend on which accesses a sampling window
//   happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

struct Box { int guard; int payload; };

static void store_inner(int* target) {
    *target = 39;        // Sink
}

static void store_outer(int* target) {
    store_inner(target);
}

int main() {
    Box* box = new Box;
    box->guard = 0;
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    store_outer(&box->payload);
    const int* src_ptr = &box->payload;
    int observed = *src_ptr;        // Source
    (void) observed;
}
