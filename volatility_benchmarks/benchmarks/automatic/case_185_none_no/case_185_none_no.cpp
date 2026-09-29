// ==========================================================
// Case 185 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a reader function
//   Sink   (write): stable  - an assignment inside a writer function
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over the value member of a stack union.
//   The write is an assignment inside a writer function and the read
//   is a read inside a reader function.  Nothing in the program can
//   make a different instruction take either end of the dependency, so
//   the reported dependency structure cannot depend on which accesses
//   a sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

union Slot { long as_value; unsigned char raw[sizeof(long)]; };

static void store_value(long* target) {
    *target = 36;        // Sink
}

static long load_value(const long* source) {
    return *source;        // Source
}

int main() {
    Slot slot;
    store_value(&slot.as_value);
    long observed = load_value(&slot.as_value);
    (void) observed;
}
