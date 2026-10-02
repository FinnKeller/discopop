; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_567_bothvol_yes/case_567_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_567_bothvol_yes/case_567_bothvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4
@_ZZ4mainE4cell = internal global i16 0, align 2

; Function Attrs: mustprogress noinline norecurse nounwind ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i16, align 2
  store i32 0, ptr %1, align 4
  store i16 0, ptr @_ZZ4mainE4cell, align 2
  store i16 29, ptr @_ZZ4mainE4cell, align 2
  %3 = load i32, ptr @_ZZ4mainE4tick, align 4
  %4 = srem i32 %3, 31
  %5 = icmp eq i32 %4, 17
  br i1 %5, label %6, label %7

6:                                                ; preds = %0
  store i16 36, ptr @_ZZ4mainE4cell, align 2
  br label %7

7:                                                ; preds = %6, %0
  store i16 0, ptr %2, align 2
  %8 = load i32, ptr @_ZZ4mainE4tick, align 4
  %9 = srem i32 %8, 23
  switch i32 %9, label %20 [
    i32 11, label %10
    i32 12, label %15
  ]

10:                                               ; preds = %7
  %11 = load i16, ptr @_ZZ4mainE4cell, align 2
  %12 = sext i16 %11 to i32
  %13 = add nsw i32 %12, 1
  %14 = trunc i32 %13 to i16
  store i16 %14, ptr %2, align 2
  br label %25

15:                                               ; preds = %7
  %16 = load i16, ptr @_ZZ4mainE4cell, align 2
  %17 = sext i16 %16 to i32
  %18 = add nsw i32 %17, 2
  %19 = trunc i32 %18 to i16
  store i16 %19, ptr %2, align 2
  br label %25

20:                                               ; preds = %7
  %21 = load i16, ptr @_ZZ4mainE4cell, align 2
  %22 = sext i16 %21 to i32
  %23 = add nsw i32 %22, 3
  %24 = trunc i32 %23 to i16
  store i16 %24, ptr %2, align 2
  br label %25

25:                                               ; preds = %20, %15, %10
  %26 = load i32, ptr @_ZZ4mainE4tick, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, ptr @_ZZ4mainE4tick, align 4
  %28 = load i32, ptr %1, align 4
  ret i32 %28
}

attributes #0 = { mustprogress noinline norecurse nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 16.0.6"}
