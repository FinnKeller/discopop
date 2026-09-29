// ==========================================================
// Case 360 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a lambda
//   Sink   (write): stable  - an assignment through a reference parameter
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over the value member of a stack union.
//   The write is an assignment through a reference parameter and the
//   read is a read inside a lambda.  Nothing in the program can make a
//   different instruction take either end of the dependency, so the
//   reported dependency structure cannot depend on which accesses a
//   sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

union Slot { char as_value; unsigned char raw[sizeof(char)]; };

static void store_ref(char& target) {
    target = 43;        // Sink
}

int main() {
    Slot slot;
    store_ref(slot.as_value);
    auto src_lambda = [](const char* source) { return *source; };        // Source
    char observed = src_lambda(&slot.as_value);
    (void) observed;
}
