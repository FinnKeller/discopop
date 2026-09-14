// ==========================================================
// Case 492 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a switch over the tick counter with two rare arms and one default arm
//   Sink   (write): stable   - an assignment through a local pointer
// Idea:
//   The source end offers more than one candidate read instruction: a
//   switch over the tick counter with two rare arms and one default
//   arm. The gate tick % 31 == 17 fires on about 3 of the 100
//   repetitions, so the two rare arm read lines gets very few chances
//   to fall inside a profiling window. The write end is a single
//   instruction - an assignment through a local pointer over one
//   element of a stack array - so only the read end of the dependency
//   can change identity. No distance lever is used; rarity alone
//   carries the case. The padding is deliberately placed in front of
//   the write, so that no shadow memory clear can fall between write
//   and read and the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The two rare arm
//   read lines is expected to be the first key to vanish from the
//   sampled dependency file, which leaves the same write instruction
//   paired with a smaller set of read instructions than in the
//   baseline.
// ==========================================================

int main() {
    static int tick = 0;
    char arr[16];
    char* sink_ptr = &arr[7];
    *sink_ptr = 43;        // Sink
    char observed = 0;
    switch (tick % 31) {
    case 17:
        observed = arr[7] + 1;         // Source (rare arm)
        break;
    case 18:
        observed = arr[7] + 2;         // Source (second rare arm)
        break;
    default:
        observed = arr[7] + 3;         // Source (default arm)
        break;
    }
    tick = tick + 1;
    (void) observed;
}
