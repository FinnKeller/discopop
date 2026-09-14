// ==========================================================
// Case 578 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - two read instructions in the arms of a rare/frequent branch
//   Sink   (write): VOLATILE - two lambdas, the second one invoked only rarely
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: two lambdas, the second one invoked
//   only rarely, gated by tick % 31 == 7. On the source side: two read
//   instructions in the arms of a rare/frequent branch, gated by tick
//   % 23 == 11. The two periods are coprime, so the rare write and the
//   rare read almost never coincide and the pair of endpoints wanders
//   over four combinations across the 100 repetitions. The cell itself
//   is the value member of a stack union. Distance lever: 2560 padding
//   writes, which guarantee a shadow memory clear for every batch
//   size.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The write line
//   inside the rare lambda and the rare arm read line are both
//   expected to be under-reported under sampling, so both the key and
//   the value side of the dependency record change.
// ==========================================================

union Slot { char as_value; unsigned char raw[sizeof(char)]; };

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
    Slot slot;
    auto store_common = [](char* target) { *target = 76; };   // Sink (frequent)
    auto store_rare = [](char* target) { *target = 83; };   // Sink (rare)
    if (tick % 31 == 7) {
        store_rare(&slot.as_value);
    } else {
        store_common(&slot.as_value);
    }
    pad_writes(40);
    char observed = 0;
    if (tick % 23 == 11) {
        observed = slot.as_value + 1;         // Source (rare arm)
    } else {
        observed = slot.as_value + 2;         // Source (frequent arm)
    }
    tick = tick + 1;
    (void) observed;
}
