// ==========================================================
// Case 334 - Volatility split 1: no volatility
//   Source (read) : stable  - a read two call levels down
//   Sink   (write): stable  - an assignment reached through a function pointer with a single target
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a heap cell whose address moves
//   every repetition. The write is an assignment reached through a
//   function pointer with a single target and the read is a read two
//   call levels down.  Nothing in the program can make a different
//   instruction take either end of the dependency, so the reported
//   dependency structure cannot depend on which accesses a sampling
//   window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static void store_value(char* target) {
    *target = 43;        // Sink
}

static char load_inner(const char* source) {
    return *source;        // Source
}

static char load_outer(const char* source) {
    return load_inner(source);
}

int main() {
    char* cell = new char(0);
    void (*sink_fp)(char*) = store_value;
    sink_fp(cell);
    char observed = load_outer(cell);
    (void) observed;
}
