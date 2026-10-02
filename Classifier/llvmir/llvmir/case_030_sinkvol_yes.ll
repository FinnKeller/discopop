; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_030_sinkvol_yes/case_030_sinkvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_030_sinkvol_yes/case_030_sinkvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse nounwind ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %2, align 4
  %4 = load i32, ptr @_ZZ4mainE4tick, align 4
  %5 = srem i32 %4, 7
  switch i32 %5, label %12 [
    i32 0, label %6
    i32 1, label %7
    i32 2, label %8
    i32 3, label %9
    i32 4, label %10
    i32 5, label %11
  ]

6:                                                ; preds = %0
  store i32 10, ptr %2, align 4
  br label %13

7:                                                ; preds = %0
  store i32 11, ptr %2, align 4
  br label %13

8:                                                ; preds = %0
  store i32 12, ptr %2, align 4
  br label %13

9:                                                ; preds = %0
  store i32 13, ptr %2, align 4
  br label %13

10:                                               ; preds = %0
  store i32 14, ptr %2, align 4
  br label %13

11:                                               ; preds = %0
  store i32 15, ptr %2, align 4
  br label %13

12:                                               ; preds = %0
  store i32 16, ptr %2, align 4
  br label %13

13:                                               ; preds = %12, %11, %10, %9, %8, %7, %6
  %14 = load i32, ptr %2, align 4
  store i32 %14, ptr %3, align 4
  %15 = load i32, ptr @_ZZ4mainE4tick, align 4
  %16 = add nsw i32 %15, 1
  store i32 %16, ptr @_ZZ4mainE4tick, align 4
  %17 = load i32, ptr %1, align 4
  ret i32 %17
}

attributes #0 = { mustprogress noinline norecurse nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 16.0.6"}
