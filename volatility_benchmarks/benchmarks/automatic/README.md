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

| Split | Source (read) | Sink (write) | Signature            | Cases in this set | Reference       |
|-------|---------------|--------------|----------------------|-------------------|-----------------|
| 1     | stable        | stable       | `5 RAW 7` always     | 001-025 (`_none_`)   | case_0, case_4  |
| 2     | stable        | volatile     | `5 RAW 7` / `5 RAW 9`| 026-050 (`_sinkvol_`)| case_1, case_5  |
| 3     | volatile      | stable       | `5 RAW 7` / `3 RAW 7`| 051-075 (`_srcvol_`) | case_2, case_6  |
| 4     | volatile      | volatile     | `5 RAW 7` / `3 RAW 9`| 076-100 (`_bothvol_`)| case_3, case_7  |

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
