// ==========================================================
// Case 468 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a frequent read plus a rare extra read of the same cell
//   Sink   (write): stable   - an assignment through a three hop pointer chain
// Idea:
//   The source end offers more than one candidate read instruction: a
//   frequent read plus a rare extra read of the same cell. The gate
//   tick % 31 == 7 fires on about 3 of the 100 repetitions, so the
//   extra read line gets very few chances to fall inside a profiling
//   window. The write end is a single instruction - an assignment
//   through a three hop pointer chain over one element of a stack
//   array - so only the read end of the dependency can change
//   identity. No distance lever is used; rarity alone carries the
//   case. The padding is deliberately placed in front of the write, so
//   that no shadow memory clear can fall between write and read and
//   the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The extra read line
//   is expected to be the first key to vanish from the sampled
//   dependency file, which leaves the same write instruction paired
//   with a smaller set of read instructions than in the baseline.
// ==========================================================

int main() {
    static int tick = 0;
    unsigned int arr[16];
    unsigned int* hop_a = &arr[7];
    unsigned int* hop_b = hop_a;
    unsigned int* hop_c = hop_b;
    *hop_c = 44;        // Sink
    unsigned int observed = arr[7];              // Source (frequent)
    if (tick % 31 == 7) {
        observed += arr[7];            // Source (rare extra read)
    }
    tick = tick + 1;
    (void) observed;
}
