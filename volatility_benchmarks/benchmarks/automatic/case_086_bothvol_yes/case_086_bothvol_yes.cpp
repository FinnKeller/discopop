#include <stdio.h>
#include <stdlib.h>

// ============================================================
// Case 086 - Volatility split 4: source and sink volatile
//   Source (read) : VOLATILE - one of three reader functions
//   Sink   (write): VOLATILE - one of three writer functions
// Idea:
//   Two independent function pointer tables, one for writers and one for
//   readers. Both ends of the dependency live in a different function
//   than the other, and both are resolved indirectly at runtime.
// Expected result:
//   VOLATILE. Several of the nine writer/reader edges are expected to be
//   missing under sampling.
// ============================================================

static void store_one(int* target)   { *target = 1; }               // Sink (one)
static void store_two(int* target)   { *target = 2; }               // Sink (two)
static void store_three(int* target) { *target = 3; }               // Sink (three)

static int fetch_one(const int* source)   { return *source + 1; }   // Source (one)
static int fetch_two(const int* source)   { return *source + 2; }   // Source (two)
static int fetch_three(const int* source) { return *source + 3; }   // Source (three)

int main() {
    int a = 0;

    void (*writers[3])(int*) = { store_one, store_two, store_three };
    int (*readers[3])(const int*) = { fetch_one, fetch_two, fetch_three };

    writers[rand() % 3](&a);
    int x = readers[rand() % 3](&a);
    (void) x;
}
