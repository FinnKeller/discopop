// ==========================================================
// Case 175 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a function template instance
//   Sink   (write): stable  - an assignment through a reference parameter
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a field of a heap struct. The
//   write is an assignment through a reference parameter and the read
//   is a read inside a function template instance. Added noise: a dead
//   store to an unrelated variable. Nothing in the program can make a
//   different instruction take either end of the dependency, so the
//   reported dependency structure cannot depend on which accesses a
//   sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

struct Box { long guard; long payload; };

static void store_ref(long& target) {
    target = 41;        // Sink
}

template <typename V>
static V load_generic(const V* source) {
    return *source;        // Source
}

int main() {
    Box* box = new Box;
    box->guard = 0;
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    store_ref(box->payload);
    long observed = load_generic<long>(&box->payload);
    (void) observed;
}
