// ==========================================================
// Case 514 - Volatility split 3: source volatile only
//   Source (read) : VOLATILE - two reader functions, the second one called only rarely
//   Sink   (write): stable   - an assignment two call levels down
// Idea:
//   The source end offers more than one candidate read instruction:
//   two reader functions, the second one called only rarely. The gate
//   tick % 37 == 29 fires on about 2 of the 100 repetitions, so the
//   read line inside the rare reader gets very few chances to fall
//   inside a profiling window. The write end is a single instruction -
//   an assignment two call levels down over a heap cell whose address
//   moves every repetition - so only the read end of the dependency
//   can change identity. No distance lever is used; rarity alone
//   carries the case. The padding is deliberately placed in front of
//   the write, so that no shadow memory clear can fall between write
//   and read and the sink end stays untouched.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The read line inside
//   the rare reader is expected to be the first key to vanish from the
//   sampled dependency file, which leaves the same write instruction
//   paired with a smaller set of read instructions than in the
//   baseline.
// ==========================================================

static void store_inner(char* target) {
    *target = 79;        // Sink
}

static void store_outer(char* target) {
    store_inner(target);
}

static char load_common(const char* source) {
    return *source + 1;             // Source (frequent)
}

static char load_rare(const char* source) {
    return *source + 2;             // Source (rare)
}

int main() {
    static int tick = 0;
    char* cell = new char(0);
    store_outer(cell);
    char observed = 0;
    if (tick % 37 == 29) {
        observed = load_rare(cell);
    } else {
        observed = load_common(cell);
    }
    tick = tick + 1;
    (void) observed;
}
