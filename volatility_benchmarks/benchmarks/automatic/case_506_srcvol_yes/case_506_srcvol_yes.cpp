// ==========================================================
// Case 506 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a switch over the tick counter with two rare arms and one default arm
//   Sink   (write): stable   - an assignment through a three hop pointer chain
// Idea:
//   The source end offers more than one candidate read instruction: a
//   switch over the tick counter with two rare arms and one default
//   arm. The gate tick % 19 == 12 fires on about 5 of the 100
//   repetitions, so the two rare arm read lines gets very few chances
//   to fall inside a profiling window. The write end is a single
//   instruction - an assignment through a three hop pointer chain over
//   a field of a heap struct - so only the read end of the dependency
//   can change identity. Distance lever: 2560 padding writes, which
//   guarantee a shadow memory clear for every batch size. The padding
//   is deliberately placed in front of the write, so that no shadow
//   memory clear can fall between write and read and the sink end
//   stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The two rare arm
//   read lines is expected to be the first key to vanish from the
//   sampled dependency file, which leaves the same write instruction
//   paired with a smaller set of read instructions than in the
//   baseline.
// ==========================================================

struct Box { char guard; char payload; };

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
    Box* box = new Box;
    box->guard = 0;
    pad_writes(40);
    char* hop_a = &box->payload;
    char* hop_b = hop_a;
    char* hop_c = hop_b;
    *hop_c = 71;        // Sink
    char observed = 0;
    switch (tick % 19) {
    case 12:
        observed = box->payload + 1;         // Source (rare arm)
        break;
    case 13:
        observed = box->payload + 2;         // Source (second rare arm)
        break;
    default:
        observed = box->payload + 3;         // Source (default arm)
        break;
    }
    tick = tick + 1;
    (void) observed;
}
