// ==========================================================
// Case 273 - Volatility split 1: no volatility
//   Source (read) : stable  - a read reached through a function pointer with a single target
//   Sink   (write): stable  - an assignment inside a lambda
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a translation unit global scalar.
//   The write is an assignment inside a lambda and the read is a read
//   reached through a function pointer with a single target.  Nothing
//   in the program can make a different instruction take either end of
//   the dependency, so the reported dependency structure cannot depend
//   on which accesses a sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static int g_cell;

static int load_value(const int* source) {
    return *source;        // Source
}

int main() {
    g_cell = 0;
    auto sink_lambda = [](int* target) { *target = 34; };        // Sink
    sink_lambda(&g_cell);
    int (*src_fp)(const int*) = load_value;
    int observed = src_fp(&g_cell);
    (void) observed;
}
