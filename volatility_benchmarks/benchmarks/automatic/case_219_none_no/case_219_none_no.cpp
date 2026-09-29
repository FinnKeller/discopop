// ==========================================================
// Case 219 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a local pointer
//   Sink   (write): stable  - an assignment inside a lambda
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a heap cell allocated and released
//   per repetition. The write is an assignment inside a lambda and the
//   read is a read through a local pointer. Added noise: a second,
//   completely separate write/read pair on an unrelated variable.
//   Nothing in the program can make a different instruction take
//   either end of the dependency, so the reported dependency structure
//   cannot depend on which accesses a sampling window happens to
//   catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

int main() {
    unsigned int* cell = new unsigned int(0);
    int companion = 0;
    companion = 271;
    int companion_seen = companion;
    (void) companion_seen;
    auto sink_lambda = [](unsigned int* target) { *target = 39; };        // Sink
    sink_lambda(cell);
    const unsigned int* src_ptr = cell;
    unsigned int observed = *src_ptr;        // Source
    (void) observed;
    delete cell;
}
