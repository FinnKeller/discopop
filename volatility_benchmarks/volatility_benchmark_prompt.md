Background:
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
- Sink volatility: 5 RAW 7 x / 5 RAW 9 x
- Source volatility: 5 RAW 7 x / 3 RAW 7 x

Balance requirement:
- Across the full generated set, the number of "no volatility" examples (split 1) should be roughly equal to the number of "volatility" examples (the combined total of splits 2, 3 and 4).
- Within the "volatility" group, try to distribute examples reasonably evenly across sink-only, source-only, and both-volatile, but the primary balance target is no-volatility vs. volatility overall (~50/50).

Important requirement for the assistant:
- First, explain the concept of volatility in plain language.
- Then explain the concrete task in plain language.
- Then explain what to pay attention to when constructing examples.
- Then explain how the no-volatility vs. volatility balance will be maintained across all examples (existing + new).
- Only after the explanation is complete, ask for explicit user approval before generating or creating any files.
- Do not skip the explanation stage and do not start creating examples before the user accepts.

Task for the assistant:
- Create a short, interactive explanation that the user MUST explicitly accept before any work proceeds.
- After acceptance, generate 500 additional new benchmark examples in the automatic folder (on top of the existing ~100 already generated), covering different volatility splits and different complexities, while keeping the overall no-volatility vs. volatility balance roughly equal across the combined set (existing + new).
- Ensure each generated example is genuinely new and not a copy of an existing case, including cases from the original ~100.
- Comment each example with:
  - the volatility split
  - the idea behind the example
  - the expected result
- Name the examples clearly if volatility is intended.
  - case_*_no
  - case_*_yes
- From volatility_benchmarks do source ../venv/bin/activate to ensure the correct environment is used.
- After generating ALL the examples run the autotuner once.
- If a generated example does not produce the intended volatility after validation, it must be deleted from the benchmark folder. Before deletion, log its identifier, intended volatility split, and reason for invalidity in invalid_cases.txt for traceability. Invalid examples must not be modified or rewritten to appear valid — they are removed, not patched.

Execution rules:
- The assistant must not silently proceed to code generation.
- The assistant must stop after the explanation and wait for approval.
- After approval, the assistant must generate examples with different volatility splits, respecting the ~50/50 no-volatility/volatility balance.
- Each example must be clearly labeled and documented.
- Invalid examples are deleted after validation, with a corresponding entry kept in invalid_cases.txt.
- The assistant should only continue if the user explicitly confirms the plan.
