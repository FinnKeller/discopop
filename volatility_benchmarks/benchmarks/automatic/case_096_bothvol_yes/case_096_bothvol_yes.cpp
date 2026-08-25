#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 096 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - one read instruction per reader override
//   Sink   (write): VOLATILE - one write instruction per writer override
// Idea:
//   Virtual dispatch on both ends. Two writer classes and two reader
//   classes are selected independently, so the edge is one of four
//   override pairs and neither end can be resolved without running the
//   program.
// Expected result:
//   VOLATILE. Several of the four override pairs are expected to be
//   missing from the sampled dependency set.
// ============================================================

struct Storer {
    virtual void store(int* target) = 0;
    virtual ~Storer() {}
};

struct StorerLow : Storer {
    void store(int* target) { *target = 1; }                    // Sink (low)
};

struct StorerHigh : Storer {
    void store(int* target) { *target = 2; }                    // Sink (high)
};

struct Loader {
    virtual int load(const int* source) = 0;
    virtual ~Loader() {}
};

struct LoaderPlain : Loader {
    int load(const int* source) { return *source; }              // Source (plain)
};

struct LoaderScaled : Loader {
    int load(const int* source) { return *source * 3; }          // Source (scaled)
};

int main() {
    int a = 0;

    StorerLow storer_low;
    StorerHigh storer_high;
    LoaderPlain loader_plain;
    LoaderScaled loader_scaled;

    Storer* storer = (rand() % 2 == 0) ? (Storer*) &storer_low : (Storer*) &storer_high;
    Loader* loader = (rand() % 2 == 0) ? (Loader*) &loader_plain : (Loader*) &loader_scaled;

    storer->store(&a);
    int x = loader->load(&a);
    (void) x;
}
