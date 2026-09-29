// ==========================================================
// Case 150 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a lambda
//   Sink   (write): stable  - an assignment through a three hop pointer chain
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over the value member of a stack union.
//   The write is an assignment through a three hop pointer chain and
//   the read is a read inside a lambda.  Nothing in the program can
//   make a different instruction take either end of the dependency, so
//   the reported dependency structure cannot depend on which accesses
//   a sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

union Slot { int as_value; unsigned char raw[sizeof(int)]; };

int main() {
    Slot slot;
    int* hop_a = &slot.as_value;
    int* hop_b = hop_a;
    int* hop_c = hop_b;
    *hop_c = 36;        // Sink
    auto src_lambda = [](const int* source) { return *source; };        // Source
    int observed = src_lambda(&slot.as_value);
    (void) observed;
}
