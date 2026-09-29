; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_033_sinkvol_yes/case_033_sinkvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_033_sinkvol_yes/case_033_sinkvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [4 x [4 x i32]], align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %3, align 4
  br label %7

7:                                                ; preds = %25, %0
  %8 = load i32, ptr %3, align 4
  %9 = icmp slt i32 %8, 4
  br i1 %9, label %10, label %28

10:                                               ; preds = %7
  store i32 0, ptr %4, align 4
  br label %11

11:                                               ; preds = %21, %10
  %12 = load i32, ptr %4, align 4
  %13 = icmp slt i32 %12, 4
  br i1 %13, label %14, label %24

14:                                               ; preds = %11
  %15 = load i32, ptr %3, align 4
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds [4 x [4 x i32]], ptr %2, i64 0, i64 %16
  %18 = load i32, ptr %4, align 4
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds [4 x i32], ptr %17, i64 0, i64 %19
  store i32 0, ptr %20, align 4
  br label %21

21:                                               ; preds = %14
  %22 = load i32, ptr %4, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, ptr %4, align 4
  br label %11, !llvm.loop !6

24:                                               ; preds = %11
  br label %25

25:                                               ; preds = %24
  %26 = load i32, ptr %3, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, ptr %3, align 4
  br label %7, !llvm.loop !8

28:                                               ; preds = %7
  %29 = call i32 @rand()
  %30 = srem i32 %29, 4
  store i32 %30, ptr %5, align 4
  %31 = load i32, ptr %5, align 4
  %32 = icmp eq i32 %31, 0
  br i1 %32, label %33, label %36

33:                                               ; preds = %28
  %34 = getelementptr inbounds [4 x [4 x i32]], ptr %2, i64 0, i64 0
  %35 = getelementptr inbounds [4 x i32], ptr %34, i64 0, i64 1
  store i32 90, ptr %35, align 4
  br label %53

36:                                               ; preds = %28
  %37 = load i32, ptr %5, align 4
  %38 = icmp eq i32 %37, 1
  br i1 %38, label %39, label %42

39:                                               ; preds = %36
  %40 = getelementptr inbounds [4 x [4 x i32]], ptr %2, i64 0, i64 1
  %41 = getelementptr inbounds [4 x i32], ptr %40, i64 0, i64 1
  store i32 91, ptr %41, align 4
  br label %52

42:                                               ; preds = %36
  %43 = load i32, ptr %5, align 4
  %44 = icmp eq i32 %43, 2
  br i1 %44, label %45, label %48

45:                                               ; preds = %42
  %46 = getelementptr inbounds [4 x [4 x i32]], ptr %2, i64 0, i64 2
  %47 = getelementptr inbounds [4 x i32], ptr %46, i64 0, i64 1
  store i32 92, ptr %47, align 4
  br label %51

48:                                               ; preds = %42
  %49 = getelementptr inbounds [4 x [4 x i32]], ptr %2, i64 0, i64 3
  %50 = getelementptr inbounds [4 x i32], ptr %49, i64 0, i64 1
  store i32 93, ptr %50, align 4
  br label %51

51:                                               ; preds = %48, %45
  br label %52

52:                                               ; preds = %51, %39
  br label %53

53:                                               ; preds = %52, %33
  %54 = load i32, ptr %5, align 4
  %55 = sext i32 %54 to i64
  %56 = getelementptr inbounds [4 x [4 x i32]], ptr %2, i64 0, i64 %55
  %57 = getelementptr inbounds [4 x i32], ptr %56, i64 0, i64 1
  %58 = load i32, ptr %57, align 4
  store i32 %58, ptr %6, align 4
  %59 = load i32, ptr %1, align 4
  ret i32 %59
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
!8 = distinct !{!8, !7}
