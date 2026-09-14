// ==========================================================
// Case 431 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a plain read
//   Sink   (write): VOLATILE - a frequent write plus a rare patch write
// Idea:
//   The sink end offers more than one candidate write instruction: a
//   frequent write plus a rare patch write. The gate tick % 41 == 23
//   fires on about 2 of the 100 repetitions, so the patch write line
//   gets very few chances to fall inside a profiling window. The read
//   end is a single instruction - a plain read over a heap cell
//   allocated and released per repetition - so only the write end of
//   the dependency can change identity. No distance lever is used;
//   rarity alone carries the case.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The patch write line
//   is expected to be the first edge to disappear from the sampled
//   dependency set, which leaves the same read instruction paired with
//   a smaller set of write instructions than in the baseline.
// ==========================================================

int main() {
    static int tick = 0;
    int* cell = new int(0);
    *cell = 55;                       // Sink (frequent)
    if (tick % 41 == 23) {
        *cell = 62;                   // Sink (rare patch)
    }
    int observed = *cell;        // Source
    tick = tick + 1;
    (void) observed;
    delete cell;
}
