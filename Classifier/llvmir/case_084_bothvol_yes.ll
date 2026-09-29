; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_084_bothvol_yes/case_084_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_084_bothvol_yes/case_084_bothvol_yes.cpp"
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

6:                                                ; preds = %14, %0
  %7 = load i32, ptr %3, align 4
  %8 = icmp slt i32 %7, 16
  br i1 %8, label %9, label %17

9:                                                ; preds = %6
  %10 = load i32, ptr %3, align 4
  %11 = load i32, ptr %3, align 4
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds [16 x i32], ptr %2, i64 0, i64 %12
  store i32 %10, ptr %13, align 4
  br label %14

14:                                               ; preds = %9
  %15 = load i32, ptr %3, align 4
  %16 = add nsw i32 %15, 1
  store i32 %16, ptr %3, align 4
  br label %6, !llvm.loop !6

17:                                               ; preds = %6
  %18 = load i32, ptr @_ZZ4mainE4tick, align 4
  %19 = srem i32 %18, 29
  %20 = icmp eq i32 %19, 5
  br i1 %20, label %21, label %23

21:                                               ; preds = %17
  %22 = getelementptr inbounds [16 x i32], ptr %2, i64 0, i64 6
  store i32 600, ptr %22, align 4
  br label %23

23:                                               ; preds = %21, %17
  store i32 0, ptr %4, align 4
  store i32 0, ptr %5, align 4
  br label %24

24:                                               ; preds = %34, %23
  %25 = load i32, ptr %5, align 4
  %26 = icmp slt i32 %25, 16
  br i1 %26, label %27, label %37

27:                                               ; preds = %24
  %28 = load i32, ptr %5, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds [16 x i32], ptr %2, i64 0, i64 %29
  %31 = load i32, ptr %30, align 4
  %32 = load i32, ptr %4, align 4
  %33 = add nsw i32 %32, %31
  store i32 %33, ptr %4, align 4
  br label %34

34:                                               ; preds = %27
  %35 = load i32, ptr %5, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, ptr %5, align 4
  br label %24, !llvm.loop !8

37:                                               ; preds = %24
  %38 = load i32, ptr @_ZZ4mainE4tick, align 4
  %39 = srem i32 %38, 31
  %40 = icmp eq i32 %39, 17
  br i1 %40, label %41, label %47

41:                                               ; preds = %37
  %42 = getelementptr inbounds [16 x i32], ptr %2, i64 0, i64 6
  %43 = load i32, ptr %42, align 4
  %44 = mul nsw i32 %43, 3
  %45 = load i32, ptr %4, align 4
  %46 = add nsw i32 %45, %44
  store i32 %46, ptr %4, align 4
  br label %47

47:                                               ; preds = %41, %37
  %48 = load i32, ptr @_ZZ4mainE4tick, align 4
  %49 = add nsw i32 %48, 1
  store i32 %49, ptr @_ZZ4mainE4tick, align 4
  %50 = load i32, ptr %1, align 4
  ret i32 %50
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
