// ==========================================================
// Case 471 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - two read instructions in the arms of a rare/frequent branch
//   Sink   (write): stable   - an assignment inside a function template instance
// Idea:
//   The source end offers more than one candidate read instruction:
//   two read instructions in the arms of a rare/frequent branch. The
//   gate tick % 23 == 11 fires on about 4 of the 100 repetitions, so
//   the rare arm read line gets very few chances to fall inside a
//   profiling window. The write end is a single instruction - an
//   assignment inside a function template instance over a function
//   local static scalar - so only the read end of the dependency can
//   change identity. No distance lever is used; rarity alone carries
//   the case. The padding is deliberately placed in front of the
//   write, so that no shadow memory clear can fall between write and
//   read and the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The rare arm read
//   line is expected to be the first key to vanish from the sampled
//   dependency file, which leaves the same write instruction paired
//   with a smaller set of read instructions than in the baseline.
// ==========================================================

template <typename V>
static void store_generic(V* target, V value) {
    *target = value;        // Sink
}

int main() {
    static int tick = 0;
    static short cell;
    cell = 0;
    store_generic<short>(&cell, 54);
    short observed = 0;
    if (tick % 23 == 11) {
        observed = cell + 1;         // Source (rare arm)
    } else {
        observed = cell + 2;         // Source (frequent arm)
    }
    tick = tick + 1;
    (void) observed;
}
