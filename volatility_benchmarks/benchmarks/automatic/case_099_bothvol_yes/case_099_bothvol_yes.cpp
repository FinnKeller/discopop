#include <stdio.h>

// ============================================================
// Case 099 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - one read per hand written dispatch entry
//   Sink   (write): VOLATILE - one write per hand written dispatch entry
// Idea:
//   A table of structures, each carrying a writer and a reader function
//   pointer. Both ends of the dependency are selected by the same data
//   driven index, so the edges are correlated pairs chosen at runtime
//   without any control flow branch in main.
// Expected result:
//   VOLATILE. At least one of the three paired edges is expected to be
//   missing under sampling.
// ============================================================

struct Codec {
    void (*encode)(int*);
    int (*decode)(const int*);
};

static void encode_a(int* target) { *target = 5; }                  // Sink (a)
static void encode_b(int* target) { *target = 6; }                  // Sink (b)
static void encode_c(int* target) { *target = 7; }                  // Sink (c)

static int decode_a(const int* source) { return *source + 1; }      // Source (a)
static int decode_b(const int* source) { return *source + 2; }      // Source (b)
static int decode_c(const int* source) { return *source + 3; }      // Source (c)

int main() {
    static int tick = 0;

    Codec codecs[3];
    codecs[0].encode = encode_a; codecs[0].decode = decode_a;
    codecs[1].encode = encode_b; codecs[1].decode = decode_b;
    codecs[2].encode = encode_c; codecs[2].decode = decode_c;

    int a = 0;
    Codec* selected = &codecs[tick % 3];
    selected->encode(&a);
    int x = selected->decode(&a);
    tick = tick + 1;
    (void) x;
}
