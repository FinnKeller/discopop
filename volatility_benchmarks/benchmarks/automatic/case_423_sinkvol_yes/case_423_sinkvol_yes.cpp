// ==========================================================
// Case 423 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read through a local pointer
//   Sink   (write): VOLATILE - two loop shapes carrying two different write instructions
// Idea:
//   The sink end offers more than one candidate write instruction: two
//   loop shapes carrying two different write instructions. The gate
//   tick % 29 == 19 fires on about 3 of the 100 repetitions, so the
//   write line of the rare loop shape gets very few chances to fall
//   inside a profiling window. The read end is a single instruction -
//   a read through a local pointer over a heap cell allocated and
//   released per repetition - so only the write end of the dependency
//   can change identity. Distance lever: 2560 padding reads, which
//   shift the window phase from repetition to repetition.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line of
//   the rare loop shape is expected to be the first edge to disappear
//   from the sampled dependency set, which leaves the same read
//   instruction paired with a smaller set of write instructions than
//   in the baseline.
// ==========================================================

static int pad_area[64];

static int pad_reads(int rounds) {
    int sum = 0;
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
            sum += pad_area[i];
        }
    }
    return sum;
}

int main() {
    static int tick = 0;
    int* cell = new int(0);
    if (tick % 29 == 19) {
        for (int i = 0; i < 16; i += 1) {
            if (i == 7) { *cell = 29; } // Sink (rare dense loop)
        }
    } else {
        for (int i = 0; i < 16; i += 7) {
            if (i == 7) { *cell = 22; } // Sink (frequent sparse loop)
        }
    }
    int pad_noise = pad_reads(40);
    (void) pad_noise;
    const int* src_ptr = cell;
    int observed = *src_ptr;        // Source
    tick = tick + 1;
    (void) observed;
    delete cell;
}
