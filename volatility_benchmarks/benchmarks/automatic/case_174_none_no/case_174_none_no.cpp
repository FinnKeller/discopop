// ==========================================================
// Case 174 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a reader function
//   Sink   (write): stable  - an assignment two call levels down
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a field of a heap struct. The
//   write is an assignment two call levels down and the read is a read
//   inside a reader function.  Nothing in the program can make a
//   different instruction take either end of the dependency, so the
//   reported dependency structure cannot depend on which accesses a
//   sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

struct Box { long guard; long payload; };

static void store_inner(long* target) {
    *target = 39;        // Sink
}

static void store_outer(long* target) {
    store_inner(target);
}

static long load_value(const long* source) {
    return *source;        // Source
}

int main() {
    Box* box = new Box;
    box->guard = 0;
    store_outer(&box->payload);
    long observed = load_value(&box->payload);
    (void) observed;
}
