; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_515_srcvol_yes/case_515_srcvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_515_srcvol_yes/case_515_srcvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4
@_ZZ4mainE4cell = internal global i16 0, align 2
@_ZL8pad_area = internal global [32 x i32] zeroinitializer, align 4

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i16, align 2
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i16 0, ptr @_ZZ4mainE4cell, align 2
  %9 = call noundef i32 @_ZL9pad_readsi(i32 noundef 8)
  store i32 %9, ptr %2, align 4
  store ptr @_ZZ4mainE4cell, ptr %3, align 8
  store ptr @_ZZ4mainE4cell, ptr %4, align 8
  %10 = call i32 @rand()
  %11 = srem i32 %10, 2
  %12 = icmp eq i32 %11, 0
  br i1 %12, label %13, label %15

13:                                               ; preds = %0
  %14 = load ptr, ptr %3, align 8
  br label %17

15:                                               ; preds = %0
  %16 = load ptr, ptr %4, align 8
  br label %17

17:                                               ; preds = %15, %13
  %18 = phi ptr [ %14, %13 ], [ %16, %15 ]
  store ptr %18, ptr %5, align 8
  %19 = load ptr, ptr %5, align 8
  store i16 57, ptr %19, align 2
  store i16 0, ptr %6, align 2
  %20 = load i32, ptr @_ZZ4mainE4tick, align 4
  %21 = srem i32 %20, 23
  %22 = icmp eq i32 %21, 11
  br i1 %22, label %23, label %42

23:                                               ; preds = %17
  store i32 0, ptr %7, align 4
  br label %24

24:                                               ; preds = %38, %23
  %25 = load i32, ptr %7, align 4
  %26 = icmp slt i32 %25, 16
  br i1 %26, label %27, label %41

27:                                               ; preds = %24
  %28 = load i32, ptr %7, align 4
  %29 = icmp eq i32 %28, 7
  br i1 %29, label %30, label %37

30:                                               ; preds = %27
  %31 = load i16, ptr @_ZZ4mainE4cell, align 2
  %32 = sext i16 %31 to i32
  %33 = load i16, ptr %6, align 2
  %34 = sext i16 %33 to i32
  %35 = add nsw i32 %34, %32
  %36 = trunc i32 %35 to i16
  store i16 %36, ptr %6, align 2
  br label %37

37:                                               ; preds = %30, %27
  br label %38

38:                                               ; preds = %37
  %39 = load i32, ptr %7, align 4
  %40 = add nsw i32 %39, 1
  store i32 %40, ptr %7, align 4
  br label %24, !llvm.loop !6

41:                                               ; preds = %24
  br label %61

42:                                               ; preds = %17
  store i32 0, ptr %8, align 4
  br label %43

43:                                               ; preds = %57, %42
  %44 = load i32, ptr %8, align 4
  %45 = icmp slt i32 %44, 16
  br i1 %45, label %46, label %60

46:                                               ; preds = %43
  %47 = load i32, ptr %8, align 4
  %48 = icmp eq i32 %47, 7
  br i1 %48, label %49, label %56

49:                                               ; preds = %46
  %50 = load i16, ptr @_ZZ4mainE4cell, align 2
  %51 = sext i16 %50 to i32
  %52 = load i16, ptr %6, align 2
  %53 = sext i16 %52 to i32
  %54 = add nsw i32 %53, %51
  %55 = trunc i32 %54 to i16
  store i16 %55, ptr %6, align 2
  br label %56

56:                                               ; preds = %49, %46
  br label %57

57:                                               ; preds = %56
  %58 = load i32, ptr %8, align 4
  %59 = add nsw i32 %58, 7
  store i32 %59, ptr %8, align 4
  br label %43, !llvm.loop !8

60:                                               ; preds = %43
  br label %61

61:                                               ; preds = %60, %41
  %62 = load i32, ptr @_ZZ4mainE4tick, align 4
  %63 = add nsw i32 %62, 1
  store i32 %63, ptr @_ZZ4mainE4tick, align 4
  %64 = load i32, ptr %1, align 4
  ret i32 %64
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

declare i32 @rand() #2

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { mustprogress noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }

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
