; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_537_bothvol_yes/case_537_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_537_bothvol_yes/case_537_bothvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4
@_ZL8pad_area = internal global [64 x i32] zeroinitializer, align 4

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [16 x i16], align 2
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i16, align 2
  store i32 0, ptr %1, align 4
  %10 = getelementptr inbounds [16 x i16], ptr %2, i64 0, i64 0
  %11 = getelementptr inbounds i16, ptr %10, i64 5
  store ptr %11, ptr %3, align 8
  %12 = load i32, ptr @_ZZ4mainE4tick, align 4
  %13 = srem i32 %12, 31
  %14 = icmp eq i32 %13, 17
  br i1 %14, label %15, label %29

15:                                               ; preds = %0
  store i32 0, ptr %4, align 4
  br label %16

16:                                               ; preds = %25, %15
  %17 = load i32, ptr %4, align 4
  %18 = icmp slt i32 %17, 16
  br i1 %18, label %19, label %28

19:                                               ; preds = %16
  %20 = load i32, ptr %4, align 4
  %21 = icmp eq i32 %20, 7
  br i1 %21, label %22, label %24

22:                                               ; preds = %19
  %23 = load ptr, ptr %3, align 8
  store i16 32, ptr %23, align 2
  br label %24

24:                                               ; preds = %22, %19
  br label %25

25:                                               ; preds = %24
  %26 = load i32, ptr %4, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, ptr %4, align 4
  br label %16, !llvm.loop !5

28:                                               ; preds = %16
  br label %43

29:                                               ; preds = %0
  store i32 0, ptr %5, align 4
  br label %30

30:                                               ; preds = %39, %29
  %31 = load i32, ptr %5, align 4
  %32 = icmp slt i32 %31, 16
  br i1 %32, label %33, label %42

33:                                               ; preds = %30
  %34 = load i32, ptr %5, align 4
  %35 = icmp eq i32 %34, 7
  br i1 %35, label %36, label %38

36:                                               ; preds = %33
  %37 = load ptr, ptr %3, align 8
  store i16 25, ptr %37, align 2
  br label %38

38:                                               ; preds = %36, %33
  br label %39

39:                                               ; preds = %38
  %40 = load i32, ptr %5, align 4
  %41 = add nsw i32 %40, 7
  store i32 %41, ptr %5, align 4
  br label %30, !llvm.loop !7

42:                                               ; preds = %30
  br label %43

43:                                               ; preds = %42, %28
  %44 = call noundef i32 @_ZL9pad_readsi(i32 noundef 40)
  store i32 %44, ptr %6, align 4
  %45 = load ptr, ptr %3, align 8
  store ptr %45, ptr %7, align 8
  %46 = load ptr, ptr %3, align 8
  store ptr %46, ptr %8, align 8
  store i16 0, ptr %9, align 2
  %47 = load i32, ptr @_ZZ4mainE4tick, align 4
  %48 = srem i32 %47, 29
  %49 = icmp eq i32 %48, 19
  br i1 %49, label %50, label %53

50:                                               ; preds = %43
  %51 = load ptr, ptr %8, align 8
  %52 = load i16, ptr %51, align 2
  store i16 %52, ptr %9, align 2
  br label %56

53:                                               ; preds = %43
  %54 = load ptr, ptr %7, align 8
  %55 = load i16, ptr %54, align 2
  store i16 %55, ptr %9, align 2
  br label %56

56:                                               ; preds = %53, %50
  %57 = load i32, ptr @_ZZ4mainE4tick, align 4
  %58 = add nsw i32 %57, 1
  store i32 %58, ptr @_ZZ4mainE4tick, align 4
  %59 = load i32, ptr %1, align 4
  ret i32 %59
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal noundef i32 @_ZL9pad_readsi(i32 noundef %0) #1 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  store i32 0, ptr %3, align 4
  store i32 0, ptr %4, align 4
  br label %6

6:                                                ; preds = %25, %1
  %7 = load i32, ptr %4, align 4
  %8 = load i32, ptr %2, align 4
  %9 = icmp slt i32 %7, %8
  br i1 %9, label %10, label %28

10:                                               ; preds = %6
  store i32 0, ptr %5, align 4
  br label %11

11:                                               ; preds = %21, %10
  %12 = load i32, ptr %5, align 4
  %13 = icmp slt i32 %12, 64
  br i1 %13, label %14, label %24

14:                                               ; preds = %11
  %15 = load i32, ptr %5, align 4
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds [64 x i32], ptr @_ZL8pad_area, i64 0, i64 %16
  %18 = load i32, ptr %17, align 4
  %19 = load i32, ptr %3, align 4
  %20 = add nsw i32 %19, %18
  store i32 %20, ptr %3, align 4
  br label %21

21:                                               ; preds = %14
  %22 = load i32, ptr %5, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, ptr %5, align 4
  br label %11, !llvm.loop !8

24:                                               ; preds = %11
  br label %25

25:                                               ; preds = %24
  %26 = load i32, ptr %4, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, ptr %4, align 4
  br label %6, !llvm.loop !9

28:                                               ; preds = %6
  %29 = load i32, ptr %3, align 4
  ret i32 %29
}

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #1 = { mustprogress noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

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
