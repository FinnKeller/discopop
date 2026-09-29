; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_081_bothvol_yes/case_081_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_081_bothvol_yes/case_081_bothvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [4 x i32], align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %3, align 4
  br label %6

6:                                                ; preds = %13, %0
  %7 = load i32, ptr %3, align 4
  %8 = icmp slt i32 %7, 4
  br i1 %8, label %9, label %16

9:                                                ; preds = %6
  %10 = load i32, ptr %3, align 4
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds [4 x i32], ptr %2, i64 0, i64 %11
  store i32 0, ptr %12, align 4
  br label %13

13:                                               ; preds = %9
  %14 = load i32, ptr %3, align 4
  %15 = add nsw i32 %14, 1
  store i32 %15, ptr %3, align 4
  br label %6, !llvm.loop !6

16:                                               ; preds = %6
  store i32 2, ptr %4, align 4
  %17 = call i32 @rand()
  %18 = srem i32 %17, 4
  switch i32 %18, label %31 [
    i32 0, label %19
    i32 1, label %23
    i32 2, label %27
  ]

19:                                               ; preds = %16
  %20 = load i32, ptr %4, align 4
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds [4 x i32], ptr %2, i64 0, i64 %21
  store i32 10, ptr %22, align 4
  br label %35

23:                                               ; preds = %16
  %24 = load i32, ptr %4, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds [4 x i32], ptr %2, i64 0, i64 %25
  store i32 11, ptr %26, align 4
  br label %35

27:                                               ; preds = %16
  %28 = load i32, ptr %4, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds [4 x i32], ptr %2, i64 0, i64 %29
  store i32 12, ptr %30, align 4
  br label %35

31:                                               ; preds = %16
  %32 = load i32, ptr %4, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds [4 x i32], ptr %2, i64 0, i64 %33
  store i32 13, ptr %34, align 4
  br label %35

35:                                               ; preds = %31, %27, %23, %19
  store i32 0, ptr %5, align 4
  %36 = call i32 @rand()
  %37 = srem i32 %36, 4
  switch i32 %37, label %55 [
    i32 0, label %38
    i32 1, label %43
    i32 2, label %49
  ]

38:                                               ; preds = %35
  %39 = load i32, ptr %4, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds [4 x i32], ptr %2, i64 0, i64 %40
  %42 = load i32, ptr %41, align 4
  store i32 %42, ptr %5, align 4
  br label %61

43:                                               ; preds = %35
  %44 = load i32, ptr %4, align 4
  %45 = sext i32 %44 to i64
  %46 = getelementptr inbounds [4 x i32], ptr %2, i64 0, i64 %45
  %47 = load i32, ptr %46, align 4
  %48 = add nsw i32 %47, 1
  store i32 %48, ptr %5, align 4
  br label %61

49:                                               ; preds = %35
  %50 = load i32, ptr %4, align 4
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds [4 x i32], ptr %2, i64 0, i64 %51
  %53 = load i32, ptr %52, align 4
  %54 = mul nsw i32 %53, 2
  store i32 %54, ptr %5, align 4
  br label %61

55:                                               ; preds = %35
  %56 = load i32, ptr %4, align 4
  %57 = sext i32 %56 to i64
  %58 = getelementptr inbounds [4 x i32], ptr %2, i64 0, i64 %57
  %59 = load i32, ptr %58, align 4
  %60 = sub nsw i32 %59, 1
  store i32 %60, ptr %5, align 4
  br label %61

61:                                               ; preds = %55, %49, %43, %38
  %62 = load i32, ptr %1, align 4
  ret i32 %62
}

declare i32 @rand() #1

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }

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
