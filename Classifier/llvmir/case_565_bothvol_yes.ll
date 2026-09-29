; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_565_bothvol_yes/case_565_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_565_bothvol_yes/case_565_bothvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4
@_ZL8pad_area = internal global [32 x i32] zeroinitializer, align 4

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca i64, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %6 = call ptr @malloc(i64 noundef 8) #4
  store ptr %6, ptr %2, align 8
  %7 = load ptr, ptr %2, align 8
  store i64 0, ptr %7, align 8
  %8 = load ptr, ptr %2, align 8
  store i64 50, ptr %8, align 8
  %9 = load i32, ptr @_ZZ4mainE4tick, align 4
  %10 = srem i32 %9, 19
  %11 = icmp eq i32 %10, 12
  br i1 %11, label %12, label %14

12:                                               ; preds = %0
  %13 = load ptr, ptr %2, align 8
  store i64 57, ptr %13, align 8
  br label %14

14:                                               ; preds = %12, %0
  call void @_ZL10pad_writesi(i32 noundef 8)
  store i64 0, ptr %3, align 8
  %15 = load i32, ptr @_ZZ4mainE4tick, align 4
  %16 = srem i32 %15, 29
  %17 = icmp eq i32 %16, 19
  br i1 %17, label %18, label %35

18:                                               ; preds = %14
  store i32 0, ptr %4, align 4
  br label %19

19:                                               ; preds = %31, %18
  %20 = load i32, ptr %4, align 4
  %21 = icmp slt i32 %20, 16
  br i1 %21, label %22, label %34

22:                                               ; preds = %19
  %23 = load i32, ptr %4, align 4
  %24 = icmp eq i32 %23, 7
  br i1 %24, label %25, label %30

25:                                               ; preds = %22
  %26 = load ptr, ptr %2, align 8
  %27 = load i64, ptr %26, align 8
  %28 = load i64, ptr %3, align 8
  %29 = add nsw i64 %28, %27
  store i64 %29, ptr %3, align 8
  br label %30

30:                                               ; preds = %25, %22
  br label %31

31:                                               ; preds = %30
  %32 = load i32, ptr %4, align 4
  %33 = add nsw i32 %32, 1
  store i32 %33, ptr %4, align 4
  br label %19, !llvm.loop !6

34:                                               ; preds = %19
  br label %52

35:                                               ; preds = %14
  store i32 0, ptr %5, align 4
  br label %36

36:                                               ; preds = %48, %35
  %37 = load i32, ptr %5, align 4
  %38 = icmp slt i32 %37, 16
  br i1 %38, label %39, label %51

39:                                               ; preds = %36
  %40 = load i32, ptr %5, align 4
  %41 = icmp eq i32 %40, 7
  br i1 %41, label %42, label %47

42:                                               ; preds = %39
  %43 = load ptr, ptr %2, align 8
  %44 = load i64, ptr %43, align 8
  %45 = load i64, ptr %3, align 8
  %46 = add nsw i64 %45, %44
  store i64 %46, ptr %3, align 8
  br label %47

47:                                               ; preds = %42, %39
  br label %48

48:                                               ; preds = %47
  %49 = load i32, ptr %5, align 4
  %50 = add nsw i32 %49, 7
  store i32 %50, ptr %5, align 4
  br label %36, !llvm.loop !8

51:                                               ; preds = %36
  br label %52

52:                                               ; preds = %51, %34
  %53 = load i32, ptr @_ZZ4mainE4tick, align 4
  %54 = add nsw i32 %53, 1
  store i32 %54, ptr @_ZZ4mainE4tick, align 4
  %55 = load ptr, ptr %2, align 8
  call void @free(ptr noundef %55)
  %56 = load i32, ptr %1, align 4
  ret i32 %56
}

; Function Attrs: allocsize(0)
declare ptr @malloc(i64 noundef) #1

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @_ZL10pad_writesi(i32 noundef %0) #2 {
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
  %12 = icmp slt i32 %11, 32
  br i1 %12, label %13, label %23

13:                                               ; preds = %10
  %14 = load i32, ptr %3, align 4
  %15 = load i32, ptr %4, align 4
  %16 = xor i32 %14, %15
  %17 = load i32, ptr %4, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds [32 x i32], ptr @_ZL8pad_area, i64 0, i64 %18
  store i32 %16, ptr %19, align 4
  br label %20

20:                                               ; preds = %13
  %21 = load i32, ptr %4, align 4
  %22 = add nsw i32 %21, 1
  store i32 %22, ptr %4, align 4
  br label %10, !llvm.loop !9

23:                                               ; preds = %10
  br label %24

24:                                               ; preds = %23
  %25 = load i32, ptr %3, align 4
  %26 = add nsw i32 %25, 1
  store i32 %26, ptr %3, align 4
  br label %5, !llvm.loop !10

27:                                               ; preds = %5
  ret void
}

declare void @free(ptr noundef) #3

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { allocsize(0) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { mustprogress noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #4 = { allocsize(0) }

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
