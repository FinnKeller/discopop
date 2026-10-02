; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_082_bothvol_yes/case_082_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_082_bothvol_yes/case_082_bothvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

@_ZZ4mainE3arr = internal global [24 x i32] zeroinitializer, align 4

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %7 = call i32 @rand()
  %8 = srem i32 %7, 2
  %9 = icmp eq i32 %8, 0
  br i1 %9, label %10, label %23

10:                                               ; preds = %0
  store i32 0, ptr %2, align 4
  br label %11

11:                                               ; preds = %19, %10
  %12 = load i32, ptr %2, align 4
  %13 = icmp slt i32 %12, 24
  br i1 %13, label %14, label %22

14:                                               ; preds = %11
  %15 = load i32, ptr %2, align 4
  %16 = load i32, ptr %2, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [24 x i32], ptr @_ZZ4mainE3arr, i64 0, i64 %17
  store i32 %15, ptr %18, align 4
  br label %19

19:                                               ; preds = %14
  %20 = load i32, ptr %2, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %2, align 4
  br label %11, !llvm.loop !5

22:                                               ; preds = %11
  br label %37

23:                                               ; preds = %0
  store i32 0, ptr %3, align 4
  br label %24

24:                                               ; preds = %33, %23
  %25 = load i32, ptr %3, align 4
  %26 = icmp slt i32 %25, 24
  br i1 %26, label %27, label %36

27:                                               ; preds = %24
  %28 = load i32, ptr %3, align 4
  %29 = mul nsw i32 %28, 2
  %30 = load i32, ptr %3, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds [24 x i32], ptr @_ZZ4mainE3arr, i64 0, i64 %31
  store i32 %29, ptr %32, align 4
  br label %33

33:                                               ; preds = %27
  %34 = load i32, ptr %3, align 4
  %35 = add nsw i32 %34, 2
  store i32 %35, ptr %3, align 4
  br label %24, !llvm.loop !7

36:                                               ; preds = %24
  br label %37

37:                                               ; preds = %36, %22
  store i32 0, ptr %4, align 4
  %38 = call i32 @rand()
  %39 = srem i32 %38, 2
  %40 = icmp eq i32 %39, 0
  br i1 %40, label %41, label %56

41:                                               ; preds = %37
  store i32 0, ptr %5, align 4
  br label %42

42:                                               ; preds = %52, %41
  %43 = load i32, ptr %5, align 4
  %44 = icmp slt i32 %43, 24
  br i1 %44, label %45, label %55

45:                                               ; preds = %42
  %46 = load i32, ptr %5, align 4
  %47 = sext i32 %46 to i64
  %48 = getelementptr inbounds [24 x i32], ptr @_ZZ4mainE3arr, i64 0, i64 %47
  %49 = load i32, ptr %48, align 4
  %50 = load i32, ptr %4, align 4
  %51 = add nsw i32 %50, %49
  store i32 %51, ptr %4, align 4
  br label %52

52:                                               ; preds = %45
  %53 = load i32, ptr %5, align 4
  %54 = add nsw i32 %53, 1
  store i32 %54, ptr %5, align 4
  br label %42, !llvm.loop !8

55:                                               ; preds = %42
  br label %71

56:                                               ; preds = %37
  store i32 23, ptr %6, align 4
  br label %57

57:                                               ; preds = %67, %56
  %58 = load i32, ptr %6, align 4
  %59 = icmp sge i32 %58, 0
  br i1 %59, label %60, label %70

60:                                               ; preds = %57
  %61 = load i32, ptr %6, align 4
  %62 = sext i32 %61 to i64
  %63 = getelementptr inbounds [24 x i32], ptr @_ZZ4mainE3arr, i64 0, i64 %62
  %64 = load i32, ptr %63, align 4
  %65 = load i32, ptr %4, align 4
  %66 = add nsw i32 %65, %64
  store i32 %66, ptr %4, align 4
  br label %67

67:                                               ; preds = %60
  %68 = load i32, ptr %6, align 4
  %69 = add nsw i32 %68, -1
  store i32 %69, ptr %6, align 4
  br label %57, !llvm.loop !9

70:                                               ; preds = %57
  br label %71

71:                                               ; preds = %70, %55
  %72 = load i32, ptr %1, align 4
  ret i32 %72
}

declare i32 @rand() #1

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 16.0.6"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
!7 = distinct !{!7, !6}
!8 = distinct !{!8, !6}
!9 = distinct !{!9, !6}
