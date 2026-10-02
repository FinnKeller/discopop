; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_581_bothvol_yes/case_581_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_581_bothvol_yes/case_581_bothvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4
@_ZL6g_cell = internal global i32 0, align 4
@_ZL8pad_area = internal global [64 x i32] zeroinitializer, align 4

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr @_ZL6g_cell, align 4
  store ptr @_ZL12store_commonPj, ptr %2, align 8
  %6 = load i32, ptr @_ZZ4mainE4tick, align 4
  %7 = srem i32 %6, 31
  %8 = icmp eq i32 %7, 7
  br i1 %8, label %9, label %10

9:                                                ; preds = %0
  store ptr @_ZL10store_rarePj, ptr %2, align 8
  br label %10

10:                                               ; preds = %9, %0
  %11 = load ptr, ptr %2, align 8
  call void %11(ptr noundef @_ZL6g_cell)
  call void @_ZL10pad_writesi(i32 noundef 40)
  store i32 0, ptr %3, align 4
  %12 = load i32, ptr @_ZZ4mainE4tick, align 4
  %13 = srem i32 %12, 29
  %14 = icmp eq i32 %13, 19
  br i1 %14, label %15, label %31

15:                                               ; preds = %10
  store i32 0, ptr %4, align 4
  br label %16

16:                                               ; preds = %27, %15
  %17 = load i32, ptr %4, align 4
  %18 = icmp slt i32 %17, 16
  br i1 %18, label %19, label %30

19:                                               ; preds = %16
  %20 = load i32, ptr %4, align 4
  %21 = icmp eq i32 %20, 7
  br i1 %21, label %22, label %26

22:                                               ; preds = %19
  %23 = load i32, ptr @_ZL6g_cell, align 4
  %24 = load i32, ptr %3, align 4
  %25 = add i32 %24, %23
  store i32 %25, ptr %3, align 4
  br label %26

26:                                               ; preds = %22, %19
  br label %27

27:                                               ; preds = %26
  %28 = load i32, ptr %4, align 4
  %29 = add nsw i32 %28, 1
  store i32 %29, ptr %4, align 4
  br label %16, !llvm.loop !5

30:                                               ; preds = %16
  br label %47

31:                                               ; preds = %10
  store i32 0, ptr %5, align 4
  br label %32

32:                                               ; preds = %43, %31
  %33 = load i32, ptr %5, align 4
  %34 = icmp slt i32 %33, 16
  br i1 %34, label %35, label %46

35:                                               ; preds = %32
  %36 = load i32, ptr %5, align 4
  %37 = icmp eq i32 %36, 7
  br i1 %37, label %38, label %42

38:                                               ; preds = %35
  %39 = load i32, ptr @_ZL6g_cell, align 4
  %40 = load i32, ptr %3, align 4
  %41 = add i32 %40, %39
  store i32 %41, ptr %3, align 4
  br label %42

42:                                               ; preds = %38, %35
  br label %43

43:                                               ; preds = %42
  %44 = load i32, ptr %5, align 4
  %45 = add nsw i32 %44, 7
  store i32 %45, ptr %5, align 4
  br label %32, !llvm.loop !7

46:                                               ; preds = %32
  br label %47

47:                                               ; preds = %46, %30
  %48 = load i32, ptr @_ZZ4mainE4tick, align 4
  %49 = add nsw i32 %48, 1
  store i32 %49, ptr @_ZZ4mainE4tick, align 4
  %50 = load i32, ptr %1, align 4
  ret i32 %50
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @_ZL12store_commonPj(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  store i32 50, ptr %3, align 4
  ret void
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @_ZL10store_rarePj(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  store i32 57, ptr %3, align 4
  ret void
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @_ZL10pad_writesi(i32 noundef %0) #1 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  store i32 0, ptr %3, align 4
  br label %5

5:                                                ; preds = %24, %1
  %6 = load i32, ptr %3, align 4
  %7 = load i32, ptr %2, align 4
  %8 = icmp slt i32 %6, %7
  br i1 %8, label %9, label %27

9:                                                ; preds = %5
  store i32 0, ptr %4, align 4
  br label %10

10:                                               ; preds = %20, %9
  %11 = load i32, ptr %4, align 4
  %12 = icmp slt i32 %11, 64
  br i1 %12, label %13, label %23

13:                                               ; preds = %10
  %14 = load i32, ptr %3, align 4
  %15 = load i32, ptr %4, align 4
  %16 = xor i32 %14, %15
  %17 = load i32, ptr %4, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds [64 x i32], ptr @_ZL8pad_area, i64 0, i64 %18
  store i32 %16, ptr %19, align 4
  br label %20

20:                                               ; preds = %13
  %21 = load i32, ptr %4, align 4
  %22 = add nsw i32 %21, 1
  store i32 %22, ptr %4, align 4
  br label %10, !llvm.loop !8

23:                                               ; preds = %10
  br label %24

24:                                               ; preds = %23
  %25 = load i32, ptr %3, align 4
  %26 = add nsw i32 %25, 1
  store i32 %26, ptr %3, align 4
  br label %5, !llvm.loop !9

27:                                               ; preds = %5
  ret void
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
