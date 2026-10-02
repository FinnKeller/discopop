; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_559_bothvol_yes/case_559_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_559_bothvol_yes/case_559_bothvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4
@_ZL6g_cell = internal global i16 0, align 2

; Function Attrs: mustprogress noinline norecurse nounwind ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i16, align 2
  store i32 0, ptr %1, align 4
  store i16 0, ptr @_ZL6g_cell, align 2
  %3 = load i32, ptr @_ZZ4mainE4tick, align 4
  %4 = srem i32 %3, 41
  switch i32 %4, label %7 [
    i32 13, label %5
    i32 14, label %6
  ]

5:                                                ; preds = %0
  store i16 69, ptr @_ZL6g_cell, align 2
  br label %8

6:                                                ; preds = %0
  store i16 75, ptr @_ZL6g_cell, align 2
  br label %8

7:                                                ; preds = %0
  store i16 62, ptr @_ZL6g_cell, align 2
  br label %8

8:                                                ; preds = %7, %6, %5
  store i16 0, ptr %2, align 2
  %9 = load i32, ptr @_ZZ4mainE4tick, align 4
  %10 = srem i32 %9, 23
  switch i32 %10, label %21 [
    i32 11, label %11
    i32 12, label %16
  ]

11:                                               ; preds = %8
  %12 = load i16, ptr @_ZL6g_cell, align 2
  %13 = sext i16 %12 to i32
  %14 = add nsw i32 %13, 1
  %15 = trunc i32 %14 to i16
  store i16 %15, ptr %2, align 2
  br label %26

16:                                               ; preds = %8
  %17 = load i16, ptr @_ZL6g_cell, align 2
  %18 = sext i16 %17 to i32
  %19 = add nsw i32 %18, 2
  %20 = trunc i32 %19 to i16
  store i16 %20, ptr %2, align 2
  br label %26

21:                                               ; preds = %8
  %22 = load i16, ptr @_ZL6g_cell, align 2
  %23 = sext i16 %22 to i32
  %24 = add nsw i32 %23, 3
  %25 = trunc i32 %24 to i16
  store i16 %25, ptr %2, align 2
  br label %26

26:                                               ; preds = %21, %16, %11
  %27 = load i32, ptr @_ZZ4mainE4tick, align 4
  %28 = add nsw i32 %27, 1
  store i32 %28, ptr @_ZZ4mainE4tick, align 4
  %29 = load i32, ptr %1, align 4
  ret i32 %29
}

attributes #0 = { mustprogress noinline norecurse nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 16.0.6"}
