This is a prompt for an AI

Background volatility:
- The profiler can run with sampling enabled or disabled.
- Sampling creates a time window in which dependencies can not be observed, which can lead to missing or wrong data dependencies.
- These missing or wrong data dependencies is called volatility
- If there is no volatility, the dependency structure stays the same regardless of sampling state.

Core idea:
- A dependency can be volatile on the source side, on the sink side, on both sides, or on neither side.

Volatility split:
1. No volatility: source and sink are both not volatile
2. Sink volatile only: source stable, sink volatile
3. Source volatile only: source volatile, sink stable
4. Both volatile: source and sink volatile

Examples of the patterns: (numbers represent the instruction line number)
Format: <line> RAW <line> <var>
- Sink volatility: 5 RAW 7 x / 5 RAW 9 x
- Source volatility: 5 RAW 7 x / 3 RAW 7 x

Examples are given in volatility_benchmarks/benchmarks/{automatic/manual_checked}

1. Look at lpp_benchmarkgenerator to understand the domain specific benchmark generator rules
2. look at volatility_benchmarks to see concrete example instances of each split
3. Create a rule for lpp_benchmarkgenerator that checks for volatility.
