#include <stdlib.h>

// ==========================================================
// Case 525 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - a two slot function pointer table whose second slot is selected only rarely
//   Sink   (write): stable   - an assignment reached through a randomly indexed table whose slots are all the same function
// Idea:
//   The source end offers more than one candidate read instruction: a
//   two slot function pointer table whose second slot is selected only
//   rarely. The gate tick % 31 == 7 fires on about 3 of the 100
//   repetitions, so the read line of the rare slot gets very few
//   chances to fall inside a profiling window. The write end is a
//   single instruction - an assignment reached through a randomly
//   indexed table whose slots are all the same function over a stack
//   array element reached by pointer arithmetic - so only the read end
//   of the dependency can change identity. Distance lever: 256 padding
//   writes, enough to cross the smaller sampling windows. The padding
//   is deliberately placed in front of the write, so that no shadow
//   memory clear can fall between write and read and the sink end
//   stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The read line of the
//   rare slot is expected to be the first key to vanish from the
//   sampled dependency file, which leaves the same write instruction
//   paired with a smaller set of read instructions than in the
//   baseline.
// ==========================================================

static int pad_area[32];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 32; ++i) {
            pad_area[i] = r ^ i;
        }
    }
}

static void store_value(char* target) {
    *target = 63;        // Sink
}

static char load_common(const char* source) {
    return *source + 1;             // Source (frequent)
}

static char load_rare(const char* source) {
    return *source + 2;             // Source (rare)
}

int main() {
    static int tick = 0;
    char arr[16];
    char* cursor = arr + 5;
    pad_writes(8);
    void (*sink_table[4])(char*) = { store_value, store_value, store_value, store_value };
    sink_table[rand() % 4](cursor);
    char (*src_table[2])(const char*) = { load_common, load_rare };
    int src_slot = (tick % 31 == 7) ? 1 : 0;
    char observed = src_table[src_slot](cursor);
    tick = tick + 1;
    (void) observed;
}
