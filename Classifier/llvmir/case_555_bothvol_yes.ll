; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_555_bothvol_yes/case_555_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_555_bothvol_yes/case_555_bothvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse nounwind ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [16 x i16], align 2
  %3 = alloca i16, align 2
  store i32 0, ptr %1, align 4
  %4 = getelementptr inbounds [16 x i16], ptr %2, i64 0, i64 7
  store i16 35, ptr %4, align 2
  %5 = load i32, ptr @_ZZ4mainE4tick, align 4
  %6 = srem i32 %5, 41
  %7 = icmp eq i32 %6, 23
  br i1 %7, label %8, label %10

8:                                                ; preds = %0
  %9 = getelementptr inbounds [16 x i16], ptr %2, i64 0, i64 7
  store i16 42, ptr %9, align 2
  br label %10

10:                                               ; preds = %8, %0
  store i16 0, ptr %3, align 2
  %11 = load i32, ptr @_ZZ4mainE4tick, align 4
  %12 = srem i32 %11, 23
  switch i32 %12, label %25 [
    i32 11, label %13
    i32 12, label %19
  ]

13:                                               ; preds = %10
  %14 = getelementptr inbounds [16 x i16], ptr %2, i64 0, i64 7
  %15 = load i16, ptr %14, align 2
  %16 = sext i16 %15 to i32
  %17 = add nsw i32 %16, 1
  %18 = trunc i32 %17 to i16
  store i16 %18, ptr %3, align 2
  br label %31

19:                                               ; preds = %10
  %20 = getelementptr inbounds [16 x i16], ptr %2, i64 0, i64 7
  %21 = load i16, ptr %20, align 2
  %22 = sext i16 %21 to i32
  %23 = add nsw i32 %22, 2
  %24 = trunc i32 %23 to i16
  store i16 %24, ptr %3, align 2
  br label %31

25:                                               ; preds = %10
  %26 = getelementptr inbounds [16 x i16], ptr %2, i64 0, i64 7
  %27 = load i16, ptr %26, align 2
  %28 = sext i16 %27 to i32
  %29 = add nsw i32 %28, 3
  %30 = trunc i32 %29 to i16
  store i16 %30, ptr %3, align 2
  br label %31

31:                                               ; preds = %25, %19, %13
  %32 = load i32, ptr @_ZZ4mainE4tick, align 4
  %33 = add nsw i32 %32, 1
  store i32 %33, ptr @_ZZ4mainE4tick, align 4
  %34 = load i32, ptr %1, align 4
  ret i32 %34
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
