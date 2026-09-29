; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_475_srcvol_yes/case_475_srcvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_475_srcvol_yes/case_475_srcvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%union.Slot = type { i64 }

@_ZZ4mainE4tick = internal global i32 0, align 4
@_ZL8pad_area = internal global [32 x i32] zeroinitializer, align 4

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %union.Slot, align 8
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %8 = call noundef i32 @_ZL9pad_readsi(i32 noundef 8)
  store i32 %8, ptr %3, align 4
  store ptr %2, ptr %4, align 8
  %9 = load ptr, ptr %4, align 8
  store i64 77, ptr %9, align 8
  store i64 0, ptr %5, align 8
  %10 = load i32, ptr @_ZZ4mainE4tick, align 4
  %11 = srem i32 %10, 31
  %12 = icmp eq i32 %11, 17
  br i1 %12, label %13, label %29

13:                                               ; preds = %0
  store i32 0, ptr %6, align 4
  br label %14

14:                                               ; preds = %25, %13
  %15 = load i32, ptr %6, align 4
  %16 = icmp slt i32 %15, 16
  br i1 %16, label %17, label %28

17:                                               ; preds = %14
  %18 = load i32, ptr %6, align 4
  %19 = icmp eq i32 %18, 7
  br i1 %19, label %20, label %24

20:                                               ; preds = %17
  %21 = load i64, ptr %2, align 8
  %22 = load i64, ptr %5, align 8
  %23 = add nsw i64 %22, %21
  store i64 %23, ptr %5, align 8
  br label %24

24:                                               ; preds = %20, %17
  br label %25

25:                                               ; preds = %24
  %26 = load i32, ptr %6, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, ptr %6, align 4
  br label %14, !llvm.loop !6

28:                                               ; preds = %14
  br label %45

29:                                               ; preds = %0
  store i32 0, ptr %7, align 4
  br label %30

30:                                               ; preds = %41, %29
  %31 = load i32, ptr %7, align 4
  %32 = icmp slt i32 %31, 16
  br i1 %32, label %33, label %44

33:                                               ; preds = %30
  %34 = load i32, ptr %7, align 4
  %35 = icmp eq i32 %34, 7
  br i1 %35, label %36, label %40

36:                                               ; preds = %33
  %37 = load i64, ptr %2, align 8
  %38 = load i64, ptr %5, align 8
  %39 = add nsw i64 %38, %37
  store i64 %39, ptr %5, align 8
  br label %40

40:                                               ; preds = %36, %33
  br label %41

41:                                               ; preds = %40
  %42 = load i32, ptr %7, align 4
  %43 = add nsw i32 %42, 7
  store i32 %43, ptr %7, align 4
  br label %30, !llvm.loop !8

44:                                               ; preds = %30
  br label %45

45:                                               ; preds = %44, %28
  %46 = load i32, ptr @_ZZ4mainE4tick, align 4
  %47 = add nsw i32 %46, 1
  store i32 %47, ptr @_ZZ4mainE4tick, align 4
  %48 = load i32, ptr %1, align 4
  ret i32 %48
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
  %13 = icmp slt i32 %12, 32
  br i1 %13, label %14, label %24

14:                                               ; preds = %11
  %15 = load i32, ptr %5, align 4
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds [32 x i32], ptr @_ZL8pad_area, i64 0, i64 %16
  %18 = load i32, ptr %17, align 4
  %19 = load i32, ptr %3, align 4
  %20 = add nsw i32 %19, %18
  store i32 %20, ptr %3, align 4
  br label %21

21:                                               ; preds = %14
  %22 = load i32, ptr %5, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, ptr %5, align 4
  br label %11, !llvm.loop !9

24:                                               ; preds = %11
  br label %25

25:                                               ; preds = %24
  %26 = load i32, ptr %4, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, ptr %4, align 4
  br label %6, !llvm.loop !10

28:                                               ; preds = %6
  %29 = load i32, ptr %3, align 4
  ret i32 %29
}

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { mustprogress noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }

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
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
