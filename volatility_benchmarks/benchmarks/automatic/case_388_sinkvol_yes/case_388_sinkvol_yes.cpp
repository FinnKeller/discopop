// ==========================================================
// Case 388 - Volatility split 2: sink volatile only
//   Source (read) : stable   - a read inside a reader function
//   Sink   (write): VOLATILE - a two slot function pointer table whose second slot is selected only rarely
// Idea:
//   The sink end offers more than one candidate write instruction: a
//   two slot function pointer table whose second slot is selected only
//   rarely. The gate tick % 19 == 12 fires on about 5 of the 100
//   repetitions, so the write line of the rare slot gets very few
//   chances to fall inside a profiling window. The read end is a
//   single instruction - a read inside a reader function over the
//   value member of a stack union - so only the write end of the
//   dependency can change identity. Distance lever: 2560 padding
//   reads, which shift the window phase from repetition to repetition.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line of
//   the rare slot is expected to be the first edge to disappear from
//   the sampled dependency set, which leaves the same read instruction
//   paired with a smaller set of write instructions than in the
//   baseline.
// ==========================================================

union Slot { unsigned int as_value; unsigned char raw[sizeof(unsigned int)]; };

static void store_common(unsigned int* target) {
    *target = 45;                   // Sink (frequent)
}

static void store_rare(unsigned int* target) {
    *target = 52;                   // Sink (rare)
}

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

static unsigned int load_value(const unsigned int* source) {
    return *source;        // Source
}

int main() {
    static int tick = 0;
    Slot slot;
    void (*sink_table[2])(unsigned int*) = { store_common, store_rare };
    int sink_slot = (tick % 19 == 12) ? 1 : 0;
    sink_table[sink_slot](&slot.as_value);
    int pad_noise = pad_reads(40);
    (void) pad_noise;
    unsigned int observed = load_value(&slot.as_value);
    tick = tick + 1;
    (void) observed;
}
