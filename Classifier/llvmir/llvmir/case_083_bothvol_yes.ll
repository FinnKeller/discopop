; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_083_bothvol_yes/case_083_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_083_bothvol_yes/case_083_bothvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

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
  br label %11, !llvm.loop !5

24:                                               ; preds = %11
  br label %25

25:                                               ; preds = %24
  %26 = load i32, ptr %3, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, ptr %3, align 4
  br label %7, !llvm.loop !7

28:                                               ; preds = %7
  %29 = call i32 @rand()
  %30 = srem i32 %29, 4
  store i32 %30, ptr %5, align 4
  %31 = load i32, ptr %5, align 4
  %32 = icmp eq i32 %31, 0
  br i1 %32, label %33, label %36

33:                                               ; preds = %28
  %34 = getelementptr inbounds [4 x [4 x i32]], ptr %2, i64 0, i64 0
  %35 = getelementptr inbounds [4 x i32], ptr %34, i64 0, i64 3
  store i32 30, ptr %35, align 4
  br label %53

36:                                               ; preds = %28
  %37 = load i32, ptr %5, align 4
  %38 = icmp eq i32 %37, 1
  br i1 %38, label %39, label %42

39:                                               ; preds = %36
  %40 = getelementptr inbounds [4 x [4 x i32]], ptr %2, i64 0, i64 1
  %41 = getelementptr inbounds [4 x i32], ptr %40, i64 0, i64 3
  store i32 31, ptr %41, align 4
  br label %52

42:                                               ; preds = %36
  %43 = load i32, ptr %5, align 4
  %44 = icmp eq i32 %43, 2
  br i1 %44, label %45, label %48

45:                                               ; preds = %42
  %46 = getelementptr inbounds [4 x [4 x i32]], ptr %2, i64 0, i64 2
  %47 = getelementptr inbounds [4 x i32], ptr %46, i64 0, i64 3
  store i32 32, ptr %47, align 4
  br label %51

48:                                               ; preds = %42
  %49 = getelementptr inbounds [4 x [4 x i32]], ptr %2, i64 0, i64 3
  %50 = getelementptr inbounds [4 x i32], ptr %49, i64 0, i64 3
  store i32 33, ptr %50, align 4
  br label %51

51:                                               ; preds = %48, %45
  br label %52

52:                                               ; preds = %51, %39
  br label %53

53:                                               ; preds = %52, %33
  store i32 0, ptr %6, align 4
  %54 = load i32, ptr %5, align 4
  %55 = icmp eq i32 %54, 0
  br i1 %55, label %56, label %60

56:                                               ; preds = %53
  %57 = getelementptr inbounds [4 x [4 x i32]], ptr %2, i64 0, i64 0
  %58 = getelementptr inbounds [4 x i32], ptr %57, i64 0, i64 3
  %59 = load i32, ptr %58, align 4
  store i32 %59, ptr %6, align 4
  br label %80

60:                                               ; preds = %53
  %61 = load i32, ptr %5, align 4
  %62 = icmp eq i32 %61, 1
  br i1 %62, label %63, label %67

63:                                               ; preds = %60
  %64 = getelementptr inbounds [4 x [4 x i32]], ptr %2, i64 0, i64 1
  %65 = getelementptr inbounds [4 x i32], ptr %64, i64 0, i64 3
  %66 = load i32, ptr %65, align 4
  store i32 %66, ptr %6, align 4
  br label %79

67:                                               ; preds = %60
  %68 = load i32, ptr %5, align 4
  %69 = icmp eq i32 %68, 2
  br i1 %69, label %70, label %74

70:                                               ; preds = %67
  %71 = getelementptr inbounds [4 x [4 x i32]], ptr %2, i64 0, i64 2
  %72 = getelementptr inbounds [4 x i32], ptr %71, i64 0, i64 3
  %73 = load i32, ptr %72, align 4
  store i32 %73, ptr %6, align 4
  br label %78

74:                                               ; preds = %67
  %75 = getelementptr inbounds [4 x [4 x i32]], ptr %2, i64 0, i64 3
  %76 = getelementptr inbounds [4 x i32], ptr %75, i64 0, i64 3
  %77 = load i32, ptr %76, align 4
  store i32 %77, ptr %6, align 4
  br label %78

78:                                               ; preds = %74, %70
  br label %79

79:                                               ; preds = %78, %63
  br label %80

80:                                               ; preds = %79, %56
  %81 = load i32, ptr %1, align 4
  ret i32 %81
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
