// ==========================================================
// Case 349 - Volatility split 1: no volatility
//   Source (read) : stable  - a read two call levels down
//   Sink   (write): stable  - an assignment through a local pointer
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a heap cell whose address moves
//   every repetition. The write is an assignment through a local
//   pointer and the read is a read two call levels down. Added noise:
//   a second, completely separate write/read pair on an unrelated
//   variable. Nothing in the program can make a different instruction
//   take either end of the dependency, so the reported dependency
//   structure cannot depend on which accesses a sampling window
//   happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static short load_inner(const short* source) {
    return *source;        // Source
}

static short load_outer(const short* source) {
    return load_inner(source);
}

int main() {
    short* cell = new short(0);
    int companion = 0;
    companion = 271;
    int companion_seen = companion;
    (void) companion_seen;
    short* sink_ptr = cell;
    *sink_ptr = 39;        // Sink
    short observed = load_outer(cell);
    (void) observed;
}
