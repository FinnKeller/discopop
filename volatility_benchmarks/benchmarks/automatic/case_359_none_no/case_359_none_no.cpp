// ==========================================================
// Case 359 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a reader function
//   Sink   (write): stable  - an assignment inside a lambda
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a heap cell allocated and released
//   per repetition. The write is an assignment inside a lambda and the
//   read is a read inside a reader function. Added noise: a second,
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

static char load_value(const char* source) {
    return *source;        // Source
}

int main() {
    char* cell = new char(0);
    int companion = 0;
    companion = 271;
    int companion_seen = companion;
    (void) companion_seen;
    auto sink_lambda = [](char* target) { *target = 42; };        // Sink
    sink_lambda(cell);
    char observed = load_value(cell);
    (void) observed;
    delete cell;
}
