// ==========================================================
// Case 125 - Volatility split 1: no volatility
//   Source (read) : stable  - a read inside a reader function
//   Sink   (write): stable  - an assignment through a local pointer
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over the value member of a stack union.
//   The write is an assignment through a local pointer and the read is
//   a read inside a reader function.  Nothing in the program can make
//   a different instruction take either end of the dependency, so the
//   reported dependency structure cannot depend on which accesses a
//   sampling window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

union Slot { short as_value; unsigned char raw[sizeof(short)]; };

static short load_value(const short* source) {
    return *source;        // Source
}

int main() {
    Slot slot;
    short* sink_ptr = &slot.as_value;
    *sink_ptr = 35;        // Sink
    short observed = load_value(&slot.as_value);
    (void) observed;
}
