
Background:
Profiler has sampling window (on/off)
Volatility: If missed dependecy when profiler is off can turn into wrong / missing data dependency

Volatility is split:
1. Source and Goal is not volatile (Case 0 and Case 4)
2. Source is not volatile but goal is volatile (Case 1 and Case 5)
3. Source is volatile but goal is not volatile (Case 2 and Case 6)
4. Both are volatile (Case 3 and Case 7)

Task:
Create 4 new examples where each example has one of the split of volatility.
The examples should introduce differente structures and complexity.
Create a CmakeLists.txt file to build the examples. (similar to case 0 - 7)


Rules:
- DO NOT CHANGE the base examples 0 - 7
- The examples should be in C/C++.
- Each example should demonstrate a unique volatility split. (commented in the code)
- No print statements are allowed in the code.
- Do not execute examples or try to use the autotuner
