Background:
- The profiler can run with sampling enabled or disabled.
- Sampling creates a time window in which dependencies can not be observed, which can lead to missing or wrong data dependencies.
- These missing or wrong data dependencies is called volatility
- If there is no volatility, the dependency structure stays the same regardless of sampling state.

Core idea:
- A dependency can be volatile on the source side, on the sink side, on both sides, or on neither side.

Volatility split:
1. No volatility: source and sink are both not volatile (Case 0 and Case 4)
2. Sink volatile only: source stable, sink volatile (Case 1 and Case 5)
3. Source volatile only: source volatile, sink stable (Case 2 and Case 6)
4. Both volatile: source and sink volatile (Case 3 and Case 7)

Examples of the patterns: (numbers represent the instruction line number)
- Sink volatility: 5 RAW 7 x / 5 RAW 9 x
- Source volatility: 5 RAW 7 x / 3 RAW 7 x

Important requirement for the assistant:
- First, explain the concept of volatility in plain language.
- Then explain the concrete task in plain language.
- Then explain what to pay attention to when constructing examples.
- Only after the explanation is complete, ask for explicit user approval before generating or creating any files.
- Do not skip the explanation stage and do not start creating examples before the user accepts.

Task for the assistant:
- Create a short, interactive explanation that the user MUST explicitly accept before any work proceeds.
- After acceptance, generate new benchmark examples in the automatic folder that cover different volatility splits and different complexities.
- Ensure each generated example is genuinely new and not a copy of an existing case.
- Comment each example with:
  - the volatility split
  - the idea behind the example
  - the expected result
- Name the examples clearly if volatility is intended.
  - case_*_no
  - case_*_yes
- From volatility_benchmarks do source ../venv/bin/activate to ensure the correct environment is used.
- After generating ALL the examples run the autotuner once.
- Mark only the examples where actual result != expected result (a mismatch between intention and autotuner output). Do not mark examples where actual result matches expected result, even if the case is trivial or similar to an existing one.
- For each marked example, report:
  - the example name
  - the expected result (from the comment)
  - the actual autotuner result
Execution rules:
- The assistant must not silently proceed to code generation.
- The assistant must stop after the explanation and wait for approval.
- After approval, the assistant must generate examples with different volatility splits.
- Each example must be clearly labeled and documented.
- The assistant should only continue if the user explicitly confirms the plan.
