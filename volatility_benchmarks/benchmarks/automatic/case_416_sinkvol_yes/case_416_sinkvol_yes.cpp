// ==========================================================
// Case 416 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read inside a function template instance
//   Sink   (write): VOLATILE - two write instructions in the arms of a rare/frequent branch
// Idea:
//   The sink end offers more than one candidate write instruction: two
//   write instructions in the arms of a rare/frequent branch. The gate
//   tick % 37 == 29 fires on about 2 of the 100 repetitions, so the
//   rare arm write line gets very few chances to fall inside a
//   profiling window. The read end is a single instruction - a read
//   inside a function template instance over a field of a heap struct
//   - so only the write end of the dependency can change identity.
//   Distance lever: 2560 padding writes, which guarantee a shadow
//   memory clear for every batch size.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The rare arm write
//   line is expected to be the first edge to disappear from the
//   sampled dependency set, which leaves the same read instruction
//   paired with a smaller set of write instructions than in the
//   baseline.
// ==========================================================

struct Box { long long guard; long long payload; };

static int pad_area[64];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
            pad_area[i] = r ^ i;
        }
    }
}

template <typename V>
static V load_generic(const V* source) {
    return *source;        // Source
}

int main() {
    static int tick = 0;
    Box* box = new Box;
    box->guard = 0;
    if (tick % 37 == 29) {
        box->payload = 30;                   // Sink (rare arm)
    } else {
        box->payload = 23;                   // Sink (frequent arm)
    }
    pad_writes(40);
    long long observed = load_generic<long long>(&box->payload);
    tick = tick + 1;
    (void) observed;
}
