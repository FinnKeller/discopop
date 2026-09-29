; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_060_srcvol_yes/case_060_srcvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_060_srcvol_yes/case_060_srcvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse nounwind ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [16 x i32], align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %3, align 4
  br label %6

6:                                                ; preds = %15, %0
  %7 = load i32, ptr %3, align 4
  %8 = icmp slt i32 %7, 16
  br i1 %8, label %9, label %18

9:                                                ; preds = %6
  %10 = load i32, ptr %3, align 4
  %11 = add nsw i32 %10, 5
  %12 = load i32, ptr %3, align 4
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds [16 x i32], ptr %2, i64 0, i64 %13
  store i32 %11, ptr %14, align 4
  br label %15

15:                                               ; preds = %9
  %16 = load i32, ptr %3, align 4
  %17 = add nsw i32 %16, 1
  store i32 %17, ptr %3, align 4
  br label %6, !llvm.loop !6

18:                                               ; preds = %6
  store i32 0, ptr %4, align 4
  store i32 0, ptr %5, align 4
  br label %19

19:                                               ; preds = %29, %18
  %20 = load i32, ptr %5, align 4
  %21 = icmp slt i32 %20, 16
  br i1 %21, label %22, label %32

22:                                               ; preds = %19
  %23 = load i32, ptr %5, align 4
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds [16 x i32], ptr %2, i64 0, i64 %24
  %26 = load i32, ptr %25, align 4
  %27 = load i32, ptr %4, align 4
  %28 = add nsw i32 %27, %26
  store i32 %28, ptr %4, align 4
  br label %29

29:                                               ; preds = %22
  %30 = load i32, ptr %5, align 4
  %31 = add nsw i32 %30, 1
  store i32 %31, ptr %5, align 4
  br label %19, !llvm.loop !8

32:                                               ; preds = %19
  %33 = load i32, ptr @_ZZ4mainE4tick, align 4
  %34 = srem i32 %33, 37
  %35 = icmp eq i32 %34, 11
  br i1 %35, label %36, label %42

36:                                               ; preds = %32
  %37 = getelementptr inbounds [16 x i32], ptr %2, i64 0, i64 7
  %38 = load i32, ptr %37, align 4
  %39 = mul nsw i32 %38, 10
  %40 = load i32, ptr %4, align 4
  %41 = add nsw i32 %40, %39
  store i32 %41, ptr %4, align 4
  br label %42

42:                                               ; preds = %36, %32
  %43 = load i32, ptr @_ZZ4mainE4tick, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, ptr @_ZZ4mainE4tick, align 4
  %45 = load i32, ptr %1, align 4
  ret i32 %45
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
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
