// ==========================================================
// Case 283 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a reader function
//   Sink   (write): stable  - an assignment through a reference parameter
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a translation unit global scalar.
//   The write is an assignment through a reference parameter and the
//   read is a read inside a reader function.  Nothing in the program
//   can make a different instruction take either end of the
//   dependency, so the reported dependency structure cannot depend on
//   which accesses a sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

static unsigned int g_cell;

static void store_ref(unsigned int& target) {
    target = 31;        // Sink
}

static unsigned int load_value(const unsigned int* source) {
    return *source;        // Source
}

int main() {
    g_cell = 0;
    store_ref(g_cell);
    unsigned int observed = load_value(&g_cell);
    (void) observed;
}
