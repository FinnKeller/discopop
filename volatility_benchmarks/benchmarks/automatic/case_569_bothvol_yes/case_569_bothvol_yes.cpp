// ==========================================================
// Case 569 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - a recursive reader that rarely stops one level early, at a different read line
//   Sink   (write): VOLATILE - a switch over the tick counter with two rare arms and one default arm
// Idea:
//   Both ends of the dependency carry more than one candidate
//   instruction. On the sink side: a switch over the tick counter with
//   two rare arms and one default arm, gated by tick % 19 == 12. On
//   the source side: a recursive reader that rarely stops one level
//   early, at a different read line, gated by tick % 41 == 23. The two
//   periods are coprime, so the rare write and the rare read almost
//   never coincide and the pair of endpoints wanders over four
//   combinations across the 100 repetitions. The cell itself is a
//   function local static scalar. Distance lever: 256 padding writes,
//   enough to cross the smaller sampling windows.
// Expected result:
//   VOLATILE for at least one WRITE_SAMPLE_BATCH. The two rare arm
//   write lines and the shallow stop read line are both expected to be
//   under-reported under sampling, so both the key and the value side
//   of the dependency record change.
// ==========================================================

static int pad_area[32];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 32; ++i) {
            pad_area[i] = r ^ i;
        }
    }
}

static long long load_descend(const long long* source, int depth, int shallow) {
    if (shallow != 0 && depth == 1) {
        return *source + 2;         // Source (rare shallow stop)
    }
    if (depth == 0) {
        return *source + 1;         // Source (bottom of recursion)
    }
    return load_descend(source, depth - 1, shallow);
}

int main() {
    static int tick = 0;
    static long long cell;
    cell = 0;
    switch (tick % 19) {
    case 12:
        cell = 67;                   // Sink (rare arm)
        break;
    case 13:
        cell = 73;                   // Sink (second rare arm)
        break;
    default:
        cell = 60;                   // Sink (default arm)
        break;
    }
    pad_writes(8);
    int src_shallow = (tick % 41 == 23) ? 1 : 0;
    long long observed = load_descend(&cell, 3, src_shallow);
    tick = tick + 1;
    (void) observed;
}
