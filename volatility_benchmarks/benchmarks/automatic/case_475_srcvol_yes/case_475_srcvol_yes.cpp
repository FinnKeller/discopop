// ==========================================================
// Case 475 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - two loop shapes carrying two different read instructions
//   Sink   (write): stable   - an assignment through a local pointer
// Idea:
//   The source end offers more than one candidate read instruction:
//   two loop shapes carrying two different read instructions. The gate
//   tick % 31 == 17 fires on about 3 of the 100 repetitions, so the
//   read line of the rare loop shape gets very few chances to fall
//   inside a profiling window. The write end is a single instruction -
//   an assignment through a local pointer over the value member of a
//   stack union - so only the read end of the dependency can change
//   identity. Distance lever: 256 padding reads, enough to cross the
//   smaller sampling windows. The padding is deliberately placed in
//   front of the write, so that no shadow memory clear can fall
//   between write and read and the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The read line of the
//   rare loop shape is expected to be the first key to vanish from the
//   sampled dependency file, which leaves the same write instruction
//   paired with a smaller set of read instructions than in the
//   baseline.
// ==========================================================

union Slot { long long as_value; unsigned char raw[sizeof(long long)]; };

static int pad_area[32];

static int pad_reads(int rounds) {
    int sum = 0;
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 32; ++i) {
            sum += pad_area[i];
        }
    }
    return sum;
}

int main() {
    static int tick = 0;
    Slot slot;
    int pad_noise = pad_reads(8);
    (void) pad_noise;
    long long* sink_ptr = &slot.as_value;
    *sink_ptr = 77;        // Sink
    long long observed = 0;
    if (tick % 31 == 17) {
        for (int i = 0; i < 16; i += 1) {
            if (i == 7) { observed += slot.as_value; } // Source (rare dense loop)
        }
    } else {
        for (int i = 0; i < 16; i += 7) {
            if (i == 7) { observed += slot.as_value; } // Source (frequent sparse loop)
        }
    }
    tick = tick + 1;
    (void) observed;
}
