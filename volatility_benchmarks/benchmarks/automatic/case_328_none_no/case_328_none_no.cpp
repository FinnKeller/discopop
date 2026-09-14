// ==========================================================
// Case 328 - Volatility split 1: no volatility
//   Source (read) : stable  - a read two call levels down
//   Sink   (write): stable  - an assignment inside a lambda
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over one element of a stack array. The
//   write is an assignment inside a lambda and the read is a read two
//   call levels down.  Nothing in the program can make a different
//   instruction take either end of the dependency, so the reported
//   dependency structure cannot depend on which accesses a sampling
//   window happens to catch.
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
    short arr[16];
    auto sink_lambda = [](short* target) { *target = 39; };        // Sink
    sink_lambda(&arr[7]);
    short observed = load_outer(&arr[7]);
    (void) observed;
}
