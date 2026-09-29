// ==========================================================
// Case 119 - Volatility split 1: no volatility
//   Source (read) : stable  - a read through a const reference parameter
//   Sink   (write): stable  - an assignment inside a lambda
// Idea:
//   The observed dependency runs from one fixed write instruction to
//   one fixed read instruction over a field of a heap struct. The
//   write is an assignment inside a lambda and the read is a read
//   through a const reference parameter. Added noise: a second,
//   completely separate write/read pair on an unrelated variable.
//   Nothing in the program can make a different instruction take
//   either end of the dependency, so the reported dependency structure
//   cannot depend on which accesses a sampling window happens to
//   catch.
// Expected result:
//   STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are single
//   instructions, so the union of observed dependencies is the same
//   with and without sampling.
// ==========================================================

struct Box { char guard; char payload; };

static char load_ref(const char& source) {
    return source;        // Source
}

int main() {
    Box* box = new Box;
    box->guard = 0;
    int companion = 0;
    companion = 271;
    int companion_seen = companion;
    (void) companion_seen;
    auto sink_lambda = [](char* target) { *target = 46; };        // Sink
    sink_lambda(&box->payload);
    char observed = load_ref(box->payload);
    (void) observed;
}
