// ==========================================================
// Case 279 - Volatility split 1: no volatility
//   Source (read) : stable  - a read two call levels down
//   Sink   (write): stable  - an assignment inside a writer function
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a field of a heap struct. The
//   write is an assignment inside a writer function and the read is a
//   read two call levels down. Added noise: a second, completely
//   separate write/read pair on an unrelated variable. Nothing in the
//   program can make a different instruction take either end of the
//   dependency, so the reported dependency structure cannot depend on
//   which accesses a sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

struct Box { char guard; char payload; };

static void store_value(char* target) {
    *target = 46;        // Sink
}

static char load_inner(const char* source) {
    return *source;        // Source
}

static char load_outer(const char* source) {
    return load_inner(source);
}

int main() {
    Box* box = new Box;
    box->guard = 0;
    int companion = 0;
    companion = 271;
    int companion_seen = companion;
    (void) companion_seen;
    store_value(&box->payload);
    char observed = load_outer(&box->payload);
    (void) observed;
}
