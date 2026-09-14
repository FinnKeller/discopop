// ==========================================================
// Case 339 - Volatility split 1: no volatility
//   Source (read) : stable  - a read two call levels down
//   Sink   (write): stable  - an assignment two call levels down
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a field of a heap struct. The
//   write is an assignment two call levels down and the read is a read
//   two call levels down. Added noise: a second, completely separate
//   write/read pair on an unrelated variable. Nothing in the program
//   can make a different instruction take either end of the
//   dependency, so the reported dependency structure cannot depend on
//   which accesses a sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

struct Box { long long guard; long long payload; };

static void store_inner(long long* target) {
    *target = 50;        // Sink
}

static void store_outer(long long* target) {
    store_inner(target);
}

static long long load_inner(const long long* source) {
    return *source;        // Source
}

static long long load_outer(const long long* source) {
    return load_inner(source);
}

int main() {
    Box* box = new Box;
    box->guard = 0;
    int companion = 0;
    companion = 271;
    int companion_seen = companion;
    (void) companion_seen;
    store_outer(&box->payload);
    long long observed = load_outer(&box->payload);
    (void) observed;
}
