// ==========================================================
// Case 494 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - two loop shapes carrying two different read instructions
//   Sink   (write): stable   - an assignment through a three hop pointer chain
// Idea:
//   The source end offers more than one candidate read instruction:
//   two loop shapes carrying two different read instructions. The gate
//   tick % 19 == 12 fires on about 5 of the 100 repetitions, so the
//   read line of the rare loop shape gets very few chances to fall
//   inside a profiling window. The write end is a single instruction -
//   an assignment through a three hop pointer chain over a heap cell
//   allocated and released per repetition - so only the read end of
//   the dependency can change identity. Distance lever: 2560 padding
//   writes, which guarantee a shadow memory clear for every batch
//   size. The padding is deliberately placed in front of the write, so
//   that no shadow memory clear can fall between write and read and
//   the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The read line of the
//   rare loop shape is expected to be the first key to vanish from the
//   sampled dependency file, which leaves the same write instruction
//   paired with a smaller set of read instructions than in the
//   baseline.
// ==========================================================

static int pad_area[64];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
            pad_area[i] = r ^ i;
        }
    }
}

int main() {
    static int tick = 0;
    char* cell = new char(0);
    pad_writes(40);
    char* hop_a = cell;
    char* hop_b = hop_a;
    char* hop_c = hop_b;
    *hop_c = 56;        // Sink
    char observed = 0;
    if (tick % 19 == 12) {
        for (int i = 0; i < 16; i += 1) {
            if (i == 7) { observed += *cell; } // Source (rare dense loop)
        }
    } else {
        for (int i = 0; i < 16; i += 7) {
            if (i == 7) { observed += *cell; } // Source (frequent sparse loop)
        }
    }
    tick = tick + 1;
    (void) observed;
    delete cell;
}
