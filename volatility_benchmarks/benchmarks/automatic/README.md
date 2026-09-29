# AI generated volatility benchmarks

This directory contains AI generated examples for volatility benchmarks.

A dependency is *volatile* when the dependency structure observed by the profiler
changes depending on whether sampling is enabled. Sampling alternates between
profiling windows of `WRITE_SAMPLE_BATCH` accesses and clears the shadow memory at
every on-to-off transition, so accesses can be missed and the predecessor of an
access can be forgotten. That produces missing or wrong dependencies.

## Volatility splits

A dependency has two ends. Following the notation of `benchmarks/manual_checked`,
the *sink* is the write end and the *source* is the read end. An end is volatile
when its instruction identity is not fixed, i.e. several candidate instructions can
be the one involved.

| Split | Source (read) | Sink (write) | Signature            | Round 1 | Round 2 | Reference       |
|-------|---------------|--------------|----------------------|---------|---------|-----------------|
| 1     | stable        | stable       | `5 RAW 7` always     | 001-025 | 101-376 | case_0, case_4  |
| 2     | stable        | volatile     | `5 RAW 7` / `5 RAW 9`| 026-050 | 377-451 | case_1, case_5  |
| 3     | volatile      | stable       | `5 RAW 7` / `3 RAW 7`| 051-075 | 452-526 | case_2, case_6  |
| 4     | volatile      | volatile     | `5 RAW 7` / `3 RAW 9`| 076-100 | 527-600 | case_3, case_7  |

## Naming

    case_<NNN>_<split>_<yes|no>

`_no` means no volatility is intended (split 1), `_yes` means volatility is
intended (splits 2 to 4). Each `.cpp` file carries a header comment stating the
split, the idea behind the example and the expected result. `// Sink` and
`// Source` mark the two ends inside the code.

The directory name and the source file name must stay identical, because
`autotuner.sh` builds `${dir}.cpp` inside `${dir}`.

## Complexity tiers

Within every split the 25 cases are spread over five tiers of five cases each:

1. straight line scalars and pointers
2. arrays and pointer arithmetic
3. functions and function pointers
4. structs, heap, loops, recursion
5. multi level indirection, virtual dispatch, lambdas, hand written dispatch tables

## Mechanisms used to create volatility

* candidate multiplicity - several write or read instructions for one address,
  selected by `rand()` or by a rotating counter
* deterministic rarity - one variant is taken on only a few of the 100
  repetitions, so it has few chances to fall into an on-window
* skewed distributions - if/else-if chains whose tail arms are rare
* distance - padding accesses between write and read that exceed the largest
  batch size, which guarantees a shadow memory clear in between

Cases 022, 023 and 024 are deliberate traps: they contain `rand()` and indirect
calls, but the runtime choice cannot change the dependency endpoints, so the
dependency must stay stable. 023 and 024 confirm this; 022 is reported volatile at
the two smallest batch sizes because of the added edge artifact described at the
end of this file, not because its endpoints move.

## How to run

    cd volatility_benchmarks
    source ../venv/bin/activate
    ./autotuner.sh                       # all batch values, REPEAT_COUNT=100
    BATCH_VALUES="64 1024" ./autotuner.sh   # quick run

`autotuner.sh` rewrites `WRITE_SAMPLE_BATCH` in
`profiler/rtlib/runtimeFunctionsGlobals.cpp` and reinstalls the profiler for every
batch value, so the working tree and the venv are modified while it runs. Per case
verdicts land in `volatility_results/`, per case diffs in
`output_<case>_batch<N>.txt`. `./remove.sh` cleans all generated artifacts.

## Validation results

Run with `REPEAT_COUNT=100` and `BATCH_VALUES="64 128 256 512 1024 2048"`.
`VOL` = volatility found, `sta` = stable.

Validity criterion: a `_yes` case is valid if it is VOLATILE for at least one
batch size, a `_no` case is valid if it is STABLE for every batch size. The 26
cases that failed this criterion are listed in `invalid_cases.txt` and were left
unmodified.

For calibration, the hand checked references behave as follows under the same
settings: case_0 and case_4 (no volatility) are STABLE at 64 and 1024, while
case_1, case_2, case_3, case_5, case_6 and case_7 are VOLATILE at 64 and STABLE
at 1024. Volatility generally shows at small batch sizes and disappears once the
whole program fits into the first on-window.

```
case                              intent        64    128    256    512   1024   2048  verdict
----------------------------------------------------------------------------------------------
case_001_none_no                  no           VOL    sta    sta    sta    sta    sta  INVALID
case_002_none_no                  no           VOL    sta    sta    sta    sta    sta  INVALID
case_003_none_no                  no           VOL    VOL    sta    sta    sta    sta  INVALID
case_004_none_no                  no           VOL    VOL    sta    sta    sta    sta  INVALID
case_005_none_no                  no           VOL    sta    sta    sta    sta    sta  INVALID
case_006_none_no                  no           sta    sta    sta    sta    sta    sta  OK
case_007_none_no                  no           VOL    VOL    VOL    sta    sta    sta  INVALID
case_008_none_no                  no           VOL    VOL    VOL    sta    sta    sta  INVALID
case_009_none_no                  no           VOL    VOL    VOL    VOL    sta    sta  INVALID
case_010_none_no                  no           VOL    VOL    VOL    VOL    sta    sta  INVALID
case_011_none_no                  no           VOL    sta    sta    sta    sta    sta  INVALID
case_012_none_no                  no           VOL    sta    sta    sta    sta    sta  INVALID
case_013_none_no                  no           sta    sta    sta    sta    sta    sta  OK
case_014_none_no                  no           VOL    VOL    sta    sta    sta    sta  INVALID
case_015_none_no                  no           VOL    VOL    sta    sta    sta    sta  INVALID
case_016_none_no                  no           VOL    VOL    VOL    VOL    sta    sta  INVALID
case_017_none_no                  no           VOL    VOL    VOL    sta    sta    sta  INVALID
case_018_none_no                  no           VOL    VOL    VOL    VOL    VOL    VOL  INVALID
case_019_none_no                  no           VOL    VOL    sta    sta    sta    sta  INVALID
case_020_none_no                  no           VOL    VOL    VOL    VOL    VOL    VOL  INVALID
case_021_none_no                  no           VOL    VOL    VOL    sta    sta    sta  INVALID
case_022_none_no                  no           VOL    VOL    sta    sta    sta    sta  INVALID
case_023_none_no                  no           sta    sta    sta    sta    sta    sta  OK
case_024_none_no                  no           sta    sta    sta    sta    sta    sta  OK
case_025_none_no                  no           VOL    VOL    sta    sta    sta    sta  INVALID
case_026_sinkvol_yes              yes          sta    sta    sta    sta    sta    sta  INVALID
case_027_sinkvol_yes              yes          VOL    VOL    sta    sta    sta    sta  OK
case_028_sinkvol_yes              yes          VOL    sta    sta    sta    sta    sta  OK
case_029_sinkvol_yes              yes          VOL    VOL    sta    sta    sta    sta  OK
case_030_sinkvol_yes              yes          VOL    VOL    sta    sta    sta    sta  OK
case_031_sinkvol_yes              yes          VOL    VOL    VOL    sta    sta    sta  OK
case_032_sinkvol_yes              yes          VOL    sta    sta    sta    sta    sta  OK
case_033_sinkvol_yes              yes          VOL    VOL    VOL    sta    sta    sta  OK
case_034_sinkvol_yes              yes          VOL    VOL    VOL    VOL    VOL    VOL  OK
case_035_sinkvol_yes              yes          VOL    VOL    VOL    VOL    VOL    sta  OK
case_036_sinkvol_yes              yes          sta    sta    sta    sta    sta    sta  INVALID
case_037_sinkvol_yes              yes          VOL    VOL    sta    sta    sta    sta  OK
case_038_sinkvol_yes              yes          VOL    VOL    sta    sta    sta    sta  OK
case_039_sinkvol_yes              yes          VOL    sta    sta    sta    sta    sta  OK
case_040_sinkvol_yes              yes          VOL    VOL    sta    sta    sta    sta  OK
case_041_sinkvol_yes              yes          VOL    VOL    VOL    VOL    VOL    sta  OK
case_042_sinkvol_yes              yes          VOL    VOL    VOL    sta    sta    sta  OK
case_043_sinkvol_yes              yes          VOL    VOL    VOL    sta    sta    sta  OK
case_044_sinkvol_yes              yes          VOL    VOL    sta    sta    sta    sta  OK
case_045_sinkvol_yes              yes          VOL    VOL    sta    sta    sta    sta  OK
case_046_sinkvol_yes              yes          VOL    VOL    sta    sta    sta    sta  OK
case_047_sinkvol_yes              yes          VOL    VOL    sta    sta    sta    sta  OK
case_048_sinkvol_yes              yes          VOL    VOL    VOL    sta    sta    sta  OK
case_049_sinkvol_yes              yes          VOL    VOL    VOL    sta    sta    sta  OK
case_050_sinkvol_yes              yes          VOL    VOL    VOL    VOL    VOL    VOL  OK
case_051_srcvol_yes               yes          sta    sta    sta    sta    sta    sta  INVALID
case_052_srcvol_yes               yes          VOL    VOL    sta    sta    sta    sta  OK
case_053_srcvol_yes               yes          VOL    VOL    sta    sta    sta    sta  OK
case_054_srcvol_yes               yes          VOL    VOL    sta    sta    sta    sta  OK
case_055_srcvol_yes               yes          VOL    VOL    VOL    VOL    sta    sta  OK
case_056_srcvol_yes               yes          VOL    VOL    VOL    sta    sta    sta  OK
case_057_srcvol_yes               yes          VOL    VOL    VOL    VOL    sta    sta  OK
case_058_srcvol_yes               yes          VOL    VOL    VOL    VOL    sta    sta  OK
case_059_srcvol_yes               yes          VOL    VOL    VOL    VOL    sta    sta  OK
case_060_srcvol_yes               yes          VOL    VOL    VOL    VOL    VOL    sta  OK
case_061_srcvol_yes               yes          sta    sta    sta    sta    sta    sta  INVALID
case_062_srcvol_yes               yes          VOL    VOL    sta    sta    sta    sta  OK
case_063_srcvol_yes               yes          VOL    sta    sta    sta    sta    sta  OK
case_064_srcvol_yes               yes          VOL    VOL    sta    sta    sta    sta  OK
case_065_srcvol_yes               yes          VOL    VOL    VOL    sta    sta    sta  OK
case_066_srcvol_yes               yes          VOL    VOL    VOL    VOL    sta    sta  OK
case_067_srcvol_yes               yes          VOL    VOL    VOL    sta    sta    sta  OK
case_068_srcvol_yes               yes          VOL    VOL    VOL    sta    sta    sta  OK
case_069_srcvol_yes               yes          VOL    VOL    VOL    VOL    sta    sta  OK
case_070_srcvol_yes               yes          VOL    VOL    VOL    sta    sta    sta  OK
case_071_srcvol_yes               yes          VOL    VOL    sta    sta    sta    sta  OK
case_072_srcvol_yes               yes          VOL    VOL    sta    sta    sta    sta  OK
case_073_srcvol_yes               yes          VOL    VOL    VOL    sta    sta    sta  OK
case_074_srcvol_yes               yes          VOL    VOL    VOL    sta    sta    sta  OK
case_075_srcvol_yes               yes          VOL    VOL    VOL    VOL    VOL    VOL  OK
case_076_bothvol_yes              yes          sta    sta    sta    sta    sta    sta  INVALID
case_077_bothvol_yes              yes          VOL    VOL    VOL    sta    sta    sta  OK
case_078_bothvol_yes              yes          VOL    sta    sta    sta    sta    sta  OK
case_079_bothvol_yes              yes          VOL    VOL    VOL    sta    sta    sta  OK
case_080_bothvol_yes              yes          VOL    sta    sta    sta    sta    sta  OK
case_081_bothvol_yes              yes          VOL    sta    sta    sta    sta    sta  OK
case_082_bothvol_yes              yes          VOL    VOL    VOL    VOL    VOL    VOL  OK
case_083_bothvol_yes              yes          VOL    VOL    VOL    sta    sta    sta  OK
case_084_bothvol_yes              yes          VOL    VOL    VOL    VOL    VOL    sta  OK
case_085_bothvol_yes              yes          VOL    VOL    VOL    VOL    sta    sta  OK
case_086_bothvol_yes              yes          VOL    VOL    VOL    sta    sta    sta  OK
case_087_bothvol_yes              yes          VOL    VOL    VOL    sta    sta    sta  OK
case_088_bothvol_yes              yes          VOL    VOL    VOL    sta    sta    sta  OK
case_089_bothvol_yes              yes          VOL    sta    sta    sta    sta    sta  OK
case_090_bothvol_yes              yes          VOL    sta    sta    sta    sta    sta  OK
case_091_bothvol_yes              yes          VOL    VOL    VOL    sta    sta    sta  OK
case_092_bothvol_yes              yes          VOL    VOL    VOL    VOL    sta    sta  OK
case_093_bothvol_yes              yes          VOL    VOL    VOL    sta    sta    sta  OK
case_094_bothvol_yes              yes          VOL    VOL    VOL    VOL    sta    sta  OK
case_095_bothvol_yes              yes          VOL    VOL    sta    sta    sta    sta  OK
case_096_bothvol_yes              yes          VOL    VOL    VOL    sta    sta    sta  OK
case_097_bothvol_yes              yes          VOL    VOL    VOL    sta    sta    sta  OK
case_098_bothvol_yes              yes          VOL    VOL    VOL    VOL    sta    sta  OK
case_099_bothvol_yes              yes          VOL    VOL    VOL    sta    sta    sta  OK
case_100_bothvol_yes              yes          VOL    VOL    VOL    VOL    VOL    VOL  OK

split       total  valid  invalid
none           25      4       21
sinkvol        25     23        2
srcvol         25     23        2
bothvol        25     24        1
TOTAL         100     74       26
```

### Notes on the failures

* The five `_yes` failures use a uniform `rand() % N` choice with small `N`. Over
  100 repetitions every variant is observed many times, so the union of
  dependencies survives sampling. Rarity or distance, not uniform randomness, is
  what actually breaks a dependency set.
* The 21 `_no` failures do not lose dependencies (except case_018); sampling adds
  WAW and INIT edges because the shadow memory clear makes the runtime forget the
  previous write to an address. Any case that writes the same address more than
  once per repetition shows this as soon as the access count exceeds the batch
  size. Whether this artifact class should count as volatility is a property of
  the harness, not of the examples, so these cases are reported as measured.


---

# Round 2: cases 101-600

500 further cases were generated on top of the original 100. They are numbered
`case_101` to `case_600` and follow the same naming, commenting and directory
conventions as round 1.

## Balance

Generated so that the combined set is split evenly between the two top level
categories, counted over the 92 round 1 cases that were present in this folder
at the time:

| split          | round 1 | round 2 | generated | valid after validation |
|----------------|---------|---------|-----------|------------------------|
| `_none_no`     | 20      | 276     | 296       | 295                    |
| `_sinkvol_yes` | 25      | 75      | 100       | 84                     |
| `_srcvol_yes`  | 23      | 75      |  98       | 95                     |
| `_bothvol_yes` | 24      | 74      |  98       | 94                     |
| **no / yes**   |         |         | **296 / 296** | **295 / 273**      |

## How the round 2 cases were constructed

Round 1 lost 21 of its 25 split 1 cases, not because those programs were wrong
but because the sampling harness reports an added `WAW` / `INIT 0@0` edge for
many perfectly stable programs. Round 2 therefore started from measurement
rather than from intuition. Three calibration runs were made *before* the cases
were written:

1. **Family pilot** - 35 minimal probes, one per structural family, at all six
   batch sizes. Four families turned out to be reported volatile on their own:

   | family                                           | verdict                   |
   |--------------------------------------------------|---------------------------|
   | static or global array whose cells are written   | VOLATILE at all six sizes |
   | virtual dispatch, even with a single implementation | VOLATILE at 64 and 128 |
   | bulk write loop over a stack array               | VOLATILE at 64 to 512     |
   | elementwise write+read loop over a stack array   | VOLATILE at 64           |

   The other 29 families were stable everywhere.

2. **Pre-flight on a stratified sample** (106 cases, batch 64 and 256) - split 1
   came out at 35 percent. Two levers were responsible: a second write to the
   observed cell (3 of 33 stable) and padding placed *between* the write and the
   read (0 of 18 stable). Both are harmless in a minimal probe and stop being
   harmless in combination with anything else.

3. **Pre-flight on all 276 split 1 cases** (batch 64 and 256) - after removing
   those two levers the remaining failures were confined to three storages
   (`heap_array`, `struct_field`, `nested_struct`, all of which perform an
   auxiliary write to a second fixed address) and two decorations. Excluding
   exactly those five families left **185 of 185 measured cases stable**, with
   every remaining storage, write path, read path, decoration and type at 100
   percent.

The generator therefore composes each case from axes that were individually
measured to be stable:

* 11 storages - stack / static / global scalar, stack array element, pointer
  arithmetic, `new`/`delete`, leaked `new`, `malloc`/`free`, heap struct field,
  stack union member, randomly indexed array element
* 11 write paths - direct, local pointer, three hop pointer chain, writer
  function, reference parameter, function pointer, function pointer table with
  identical slots, lambda, two level call chain, function template, choice
  between two aliases of one object
* 8 read paths - the same idea on the read side
* 4 decorations - none, random branch on an unrelated scratch variable, dead
  store, an unrelated write/read pair
* 6 scalar types

`_yes` cases are built on the same substrates, so that a case which is reported
volatile is volatile because of its injected mechanism rather than because of a
harness artifact. Virtual dispatch is deliberately **not** used by any round 2
`_yes` case: it is volatile on its own at batch 64 and 128 and would let a case
pass the validity criterion regardless of its intended mechanism.

## Volatility mechanisms used in round 2

Rarity comes from a `static int tick` counter that survives the repeat wrapper:

    if (tick % P == R) ...

with `P` between 19 and 41, so the rare instruction fires on two to five of the
hundred repetitions. Uniform `rand() % N` is never used as the mechanism - all
five `_yes` failures of round 1 used it, and with `N` small every variant is
observed many times so the union of dependencies survives sampling.

Ten mechanisms are used on each side: rare patch, rare branch arm, rare writer
or reader function, rare function pointer retarget, rare function pointer table
slot, rare lambda, rare `switch` arm, rare recursion stop depth, rare alias and
rare loop shape. Split 4 combines one of each with coprime periods.

Distance is an independent lever: `pad_writes` / `pad_reads` of 256 or 2560
accesses. For `_srcvol_` cases the padding is placed **in front of** the write,
so that no shadow memory clear can fall between write and read and only the
source end is attacked.

## Validation results

`autotuner.sh`, `REPEAT_COUNT=100`, `BATCH_VALUES="64 128 256 512 1024 2048"`.
Per case verdicts are in `volatility_results/`.

    split            generated   valid   invalid
    -----------------------------------------------
    none_no                276     275         1
    sinkvol_yes             75      69         6
    srcvol_yes              75      75         0
    bothvol_yes             74      74         0
    -----------------------------------------------
    TOTAL                  500     493         7   (98.6 percent)

Number of cases reported VOLATILE at each batch size:

    split              n     64    128    256    512   1024   2048
    none_no          276      1      1      0      0      0      0
    sinkvol_yes       75     69     64     43     36     30     17
    srcvol_yes        75     75     75     70     62     62     62
    bothvol_yes       74     74     74     67     46     46     40

The seven invalid cases were deleted and are recorded in `invalid_cases.txt`.

### The distance lever decides reproducibility

The single clearest result of this round:

| set                                   | with a distance lever | rarity alone |
|---------------------------------------|-----------------------|--------------|
| round 2 `_yes` cases                   | 182 / 182 valid       | 36 / 43 valid |
| round 1 `_yes` cases, re-measured      | 5 / 5 valid           | 50 / 67 valid |

Every single round 2 `_yes` failure is a case with no distance lever, and all
six are `_sinkvol_` cases. Rarity alone is sufficient for the source side
(13 of 13) and for the both-volatile side (15 of 15), but it is marginal on the
sink side (8 of 14).

### Round 1 cases do not fully reproduce

This run also re-measured the 92 round 1 cases that are still in this folder.
17 of them are invalid under the stated criterion, and 15 of those are recorded
as OK in the round 1 table above - they were reported STABLE at every batch size
this time. All 17 are cases that rely on rarity alone, with no distance lever;
every round 1 case that does use a distance lever still passes.

These 17 cases were **not** deleted. They belong to round 1 and removing them is
the owner's decision, not the generator's. Their verdicts are in
`volatility_results/`. The practical conclusion is that a `_yes` case built on
rarity alone sits close to the detection threshold and its verdict is not
reliably reproducible between runs, while a case that also uses distance is.
