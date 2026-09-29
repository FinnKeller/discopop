// ==========================================================
// Case 293 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a lambda
//   Sink   (write): stable  - an assignment inside a lambda
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a plain stack scalar. The write is
//   an assignment inside a lambda and the read is a read inside a
//   lambda.  Nothing in the program can make a different instruction
//   take either end of the dependency, so the reported dependency
//   structure cannot depend on which accesses a sampling window
//   happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

int main() {
    long long cell = 0;
    auto sink_lambda = [](long long* target) { *target = 35; };        // Sink
    sink_lambda(&cell);
    auto src_lambda = [](const long long* source) { return *source; };        // Source
    long long observed = src_lambda(&cell);
    (void) observed;
}
