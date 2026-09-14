// ==========================================================
// Case 466 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - two aliases of the same cell, the second one read only rarely
//   Sink   (write): stable   - an assignment through a local pointer
// Idea:
//   The source end offers more than one candidate read instruction:
//   two aliases of the same cell, the second one read only rarely. The
//   gate tick % 29 == 19 fires on about 3 of the 100 repetitions, so
//   the read line through the rare alias gets very few chances to fall
//   inside a profiling window. The write end is a single instruction -
//   an assignment through a local pointer over a heap cell allocated
//   and released per repetition - so only the read end of the
//   dependency can change identity. No distance lever is used; rarity
//   alone carries the case. The padding is deliberately placed in
//   front of the write, so that no shadow memory clear can fall
//   between write and read and the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The read line
//   through the rare alias is expected to be the first key to vanish
//   from the sampled dependency file, which leaves the same write
//   instruction paired with a smaller set of read instructions than in
//   the baseline.
// ==========================================================

int main() {
    static int tick = 0;
    char* cell = new char(0);
    char* sink_ptr = cell;
    *sink_ptr = 53;        // Sink
    const char* src_alias_main = cell;
    const char* src_alias_rare = cell;
    char observed = 0;
    if (tick % 29 == 19) {
        observed = *src_alias_rare;    // Source (rare alias)
    } else {
        observed = *src_alias_main;    // Source (frequent alias)
    }
    tick = tick + 1;
    (void) observed;
    delete cell;
}
