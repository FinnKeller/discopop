// ==========================================================
// Case 324 - Volatility split 1: no volatility
//   Source (read) : stable  - a read two call levels down
//   Sink   (write): stable  - an assignment through a local pointer
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a heap cell whose address moves
//   every repetition. The write is an assignment through a local
//   pointer and the read is a read two call levels down.  Nothing in
//   the program can make a different instruction take either end of
//   the dependency, so the reported dependency structure cannot depend
//   on which accesses a sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static int load_inner(const int* source) {
    return *source;        // Source
}

static int load_outer(const int* source) {
    return load_inner(source);
}

int main() {
    int* cell = new int(0);
    int* sink_ptr = cell;
    *sink_ptr = 34;        // Sink
    int observed = load_outer(cell);
    (void) observed;
}
