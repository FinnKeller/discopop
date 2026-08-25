#include <stdio.h>

// ============================================================
// Case 100 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - rare virtual reader override
//   Sink   (write): VOLATILE - rare virtual writer override
// Idea:
//   The hardest construction in this set, combining every lever at once:
//   virtual dispatch on both ends, deterministic rarity with coprime
//   periods, a heap cell whose address moves every repetition, and 2560
//   padding writes between the write and the read which guarantee a
//   shadow memory clear in between for every batch size.
// Expected result:
//   VOLATILE for every batch size. Both the rare overrides and the
//   frequent ones are expected to lose their edge, since the distance
//   alone already destroys the dependency.
// ============================================================

static int scratch[64];

static void pad_writes(int rounds) {
    for (int r = 0; r < rounds; ++r) {
        for (int i = 0; i < 64; ++i) {
            scratch[i] = r ^ i;
        }
    }
}

struct Sink {
    virtual void store(int* target) = 0;
    virtual ~Sink() {}
};

struct CommonSink : Sink {
    void store(int* target) { *target = 1; }                    // Sink (frequent)
};

struct RareSink : Sink {
    void store(int* target) { *target = 2; }                    // Sink (rare)
};

struct Source {
    virtual int load(const int* source) = 0;
    virtual ~Source() {}
};

struct CommonSource : Source {
    int load(const int* source) { return *source + 1; }         // Source (frequent)
};

struct RareSource : Source {
    int load(const int* source) { return *source + 2; }         // Source (rare)
};

int main() {
    static int tick = 0;

    int* cell = new int(0);

    CommonSink common_sink;
    RareSink rare_sink;
    CommonSource common_source;
    RareSource rare_source;

    Sink* sink = &common_sink;
    if (tick % 19 == 5) {
        sink = &rare_sink;
    }

    Source* source = &common_source;
    if (tick % 23 == 11) {
        source = &rare_source;
    }

    sink->store(cell);
    pad_writes(40);
    int x = source->load(cell);

    delete cell;
    tick = tick + 1;
    (void) x;
}
