// ==========================================================
// Case 195 - Volatility split 1: no volatility
//   Source (read) : stable  - a read two call levels down
//   Sink   (write): stable  - an assignment reached through a function pointer with a single target
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over the value member of a stack union.
//   The write is an assignment reached through a function pointer with
//   a single target and the read is a read two call levels down. Added
//   noise: a second, completely separate write/read pair on an
//   unrelated variable. Nothing in the program can make a different
//   instruction take either end of the dependency, so the reported
//   dependency structure cannot depend on which accesses a sampling
//   window happens to catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

union Slot { int as_value; unsigned char raw[sizeof(int)]; };

static void store_value(int* target) {
    *target = 45;        // Sink
}

static int load_inner(const int* source) {
    return *source;        // Source
}

static int load_outer(const int* source) {
    return load_inner(source);
}

int main() {
    Slot slot;
    int companion = 0;
    companion = 271;
    int companion_seen = companion;
    (void) companion_seen;
    void (*sink_fp)(int*) = store_value;
    sink_fp(&slot.as_value);
    int observed = load_outer(&slot.as_value);
    (void) observed;
}
