// ==========================================================
// Case 477 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a two slot function pointer table whose second slot is selected only rarely
//   Sink   (write): stable   - an assignment inside a lambda
// Idea:
//   The source end offers more than one candidate read instruction: a
//   two slot function pointer table whose second slot is selected only
//   rarely. The gate tick % 31 == 17 fires on about 3 of the 100
//   repetitions, so the read line of the rare slot gets very few
//   chances to fall inside a profiling window. The write end is a
//   single instruction - an assignment inside a lambda over a stack
//   array element reached by pointer arithmetic - so only the read end
//   of the dependency can change identity. No distance lever is used;
//   rarity alone carries the case. The padding is deliberately placed
//   in front of the write, so that no shadow memory clear can fall
//   between write and read and the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The read line of the
//   rare slot is expected to be the first key to vanish from the
//   sampled dependency file, which leaves the same write instruction
//   paired with a smaller set of read instructions than in the
//   baseline.
// ==========================================================

static int load_common(const int* source) {
    return *source + 1;             // Source (frequent)
}

static int load_rare(const int* source) {
    return *source + 2;             // Source (rare)
}

int main() {
    static int tick = 0;
    int arr[16];
    int* cursor = arr + 5;
    auto sink_lambda = [](int* target) { *target = 61; };        // Sink
    sink_lambda(cursor);
    int (*src_table[2])(const int*) = { load_common, load_rare };
    int src_slot = (tick % 31 == 17) ? 1 : 0;
    int observed = src_table[src_slot](cursor);
    tick = tick + 1;
    (void) observed;
}
