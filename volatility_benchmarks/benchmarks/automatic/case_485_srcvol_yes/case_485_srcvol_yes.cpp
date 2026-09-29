#include <stdlib.h>

// ==========================================================
// Case 485 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - two lambdas, the second one invoked only rarely
//   Sink   (write): stable   - an assignment reached through a randomly indexed table whose slots are all the same function
// Idea:
//   The source end offers more than one candidate read instruction:
//   two lambdas, the second one invoked only rarely. The gate tick %
//   41 == 13 fires on about 2 of the 100 repetitions, so the read line
//   inside the rare lambda gets very few chances to fall inside a
//   profiling window. The write end is a single instruction - an
//   assignment reached through a randomly indexed table whose slots
//   are all the same function over a stack array element reached by
//   pointer arithmetic - so only the read end of the dependency can
//   change identity. Distance lever: 2560 padding writes, which
//   guarantee a shadow memory clear for every batch size. The padding
//   is deliberately placed in front of the write, so that no shadow
//   memory clear can fall between write and read and the sink end
//   stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The read line inside
//   the rare lambda is expected to be the first key to vanish from the
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

static void store_value(char* target) {
    *target = 63;        // Sink
}

int main() {
    static int tick = 0;
    char arr[16];
    char* cursor = arr + 5;
    pad_writes(40);
    void (*sink_table[4])(char*) = { store_value, store_value, store_value, store_value };
    sink_table[rand() % 4](cursor);
    auto load_common = [](const char* source) { return *source + 1; };  // Source (frequent)
    auto load_rare = [](const char* source) { return *source + 2; };    // Source (rare)
    char observed = 0;
    if (tick % 41 == 13) {
        observed = load_rare(cursor);
    } else {
        observed = load_common(cursor);
    }
    tick = tick + 1;
    (void) observed;
}
