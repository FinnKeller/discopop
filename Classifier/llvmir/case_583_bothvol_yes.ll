; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_583_bothvol_yes/case_583_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_583_bothvol_yes/case_583_bothvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse nounwind ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [16 x i64], align 8
  %3 = alloca i64, align 8
  store i32 0, ptr %1, align 4
  %4 = load i32, ptr @_ZZ4mainE4tick, align 4
  %5 = srem i32 %4, 41
  %6 = icmp eq i32 %5, 23
  br i1 %6, label %7, label %9

7:                                                ; preds = %0
  %8 = getelementptr inbounds [16 x i64], ptr %2, i64 0, i64 7
  store i64 47, ptr %8, align 8
  br label %11

9:                                                ; preds = %0
  %10 = getelementptr inbounds [16 x i64], ptr %2, i64 0, i64 7
  store i64 40, ptr %10, align 8
  br label %11

11:                                               ; preds = %9, %7
  store i64 0, ptr %3, align 8
  %12 = load i32, ptr @_ZZ4mainE4tick, align 4
  %13 = srem i32 %12, 19
  switch i32 %13, label %22 [
    i32 5, label %14
    i32 6, label %18
  ]

14:                                               ; preds = %11
  %15 = getelementptr inbounds [16 x i64], ptr %2, i64 0, i64 7
  %16 = load i64, ptr %15, align 8
  %17 = add nsw i64 %16, 1
  store i64 %17, ptr %3, align 8
  br label %26

18:                                               ; preds = %11
  %19 = getelementptr inbounds [16 x i64], ptr %2, i64 0, i64 7
  %20 = load i64, ptr %19, align 8
  %21 = add nsw i64 %20, 2
  store i64 %21, ptr %3, align 8
  br label %26

22:                                               ; preds = %11
  %23 = getelementptr inbounds [16 x i64], ptr %2, i64 0, i64 7
  %24 = load i64, ptr %23, align 8
  %25 = add nsw i64 %24, 3
  store i64 %25, ptr %3, align 8
  br label %26

26:                                               ; preds = %22, %18, %14
  %27 = load i32, ptr @_ZZ4mainE4tick, align 4
  %28 = add nsw i32 %27, 1
  store i32 %28, ptr @_ZZ4mainE4tick, align 4
  %29 = load i32, ptr %1, align 4
  ret i32 %29
}

attributes #0 = { mustprogress noinline norecurse nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 5]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Homebrew clang version 21.1.8"}
