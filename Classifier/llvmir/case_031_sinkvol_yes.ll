; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_031_sinkvol_yes/case_031_sinkvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_031_sinkvol_yes/case_031_sinkvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [8 x i32], align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %3, align 4
  br label %6

6:                                                ; preds = %13, %0
  %7 = load i32, ptr %3, align 4
  %8 = icmp slt i32 %7, 8
  br i1 %8, label %9, label %16

9:                                                ; preds = %6
  %10 = load i32, ptr %3, align 4
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds [8 x i32], ptr %2, i64 0, i64 %11
  store i32 0, ptr %12, align 4
  br label %13

13:                                               ; preds = %9
  %14 = load i32, ptr %3, align 4
  %15 = add nsw i32 %14, 1
  store i32 %15, ptr %3, align 4
  br label %6, !llvm.loop !6

16:                                               ; preds = %6
  %17 = call i32 @rand()
  %18 = srem i32 %17, 8
  store i32 %18, ptr %4, align 4
  %19 = load i32, ptr %4, align 4
  switch i32 %19, label %48 [
    i32 0, label %20
    i32 1, label %24
    i32 2, label %28
    i32 3, label %32
    i32 4, label %36
    i32 5, label %40
    i32 6, label %44
  ]

20:                                               ; preds = %16
  %21 = load i32, ptr %4, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds [8 x i32], ptr %2, i64 0, i64 %22
  store i32 70, ptr %23, align 4
  br label %52

24:                                               ; preds = %16
  %25 = load i32, ptr %4, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds [8 x i32], ptr %2, i64 0, i64 %26
  store i32 71, ptr %27, align 4
  br label %52

28:                                               ; preds = %16
  %29 = load i32, ptr %4, align 4
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds [8 x i32], ptr %2, i64 0, i64 %30
  store i32 72, ptr %31, align 4
  br label %52

32:                                               ; preds = %16
  %33 = load i32, ptr %4, align 4
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds [8 x i32], ptr %2, i64 0, i64 %34
  store i32 73, ptr %35, align 4
  br label %52

36:                                               ; preds = %16
  %37 = load i32, ptr %4, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds [8 x i32], ptr %2, i64 0, i64 %38
  store i32 74, ptr %39, align 4
  br label %52

40:                                               ; preds = %16
  %41 = load i32, ptr %4, align 4
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds [8 x i32], ptr %2, i64 0, i64 %42
  store i32 75, ptr %43, align 4
  br label %52

44:                                               ; preds = %16
  %45 = load i32, ptr %4, align 4
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds [8 x i32], ptr %2, i64 0, i64 %46
  store i32 76, ptr %47, align 4
  br label %52

48:                                               ; preds = %16
  %49 = load i32, ptr %4, align 4
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds [8 x i32], ptr %2, i64 0, i64 %50
  store i32 77, ptr %51, align 4
  br label %52

52:                                               ; preds = %48, %44, %40, %36, %32, %28, %24, %20
  %53 = load i32, ptr %4, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds [8 x i32], ptr %2, i64 0, i64 %54
  %56 = load i32, ptr %55, align 4
  store i32 %56, ptr %5, align 4
  %57 = load i32, ptr %1, align 4
  ret i32 %57
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
