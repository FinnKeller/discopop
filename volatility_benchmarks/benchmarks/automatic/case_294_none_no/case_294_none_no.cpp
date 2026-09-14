// ==========================================================
// Case 294 - Volatility split 1: no volatility
//   Source (read) : stable  - a plain read
//   Sink   (write): stable  - an assignment reached through a function pointer with a single target
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a heap cell whose address moves
//   every repetition. The write is an assignment reached through a
//   function pointer with a single target and the read is a plain
//   read. Added noise: a dead store to an unrelated variable. Nothing
//   in the program can make a different instruction take either end of
//   the dependency, so the reported dependency structure cannot depend
//   on which accesses a sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_value(short* target) {
    *target = 35;        // Sink
}

int main() {
    short* cell = new short(0);
    int unused_sink = 0;
    unused_sink = 314;
    (void) unused_sink;
    void (*sink_fp)(short*) = store_value;
    sink_fp(cell);
    short observed = *cell;        // Source
    (void) observed;
}
