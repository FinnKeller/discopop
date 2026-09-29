; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_541_bothvol_yes/case_541_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_541_bothvol_yes/case_541_bothvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4
@_ZL8pad_area = internal global [64 x i32] zeroinitializer, align 4

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i64, align 8
  store i32 0, ptr %1, align 4
  %6 = call ptr @malloc(i64 noundef 8) #4
  store ptr %6, ptr %2, align 8
  %7 = load ptr, ptr %2, align 8
  store i64 0, ptr %7, align 8
  %8 = load i32, ptr @_ZZ4mainE4tick, align 4
  %9 = srem i32 %8, 41
  %10 = icmp eq i32 %9, 23
  br i1 %10, label %11, label %25

11:                                               ; preds = %0
  store i32 0, ptr %3, align 4
  br label %12

12:                                               ; preds = %21, %11
  %13 = load i32, ptr %3, align 4
  %14 = icmp slt i32 %13, 16
  br i1 %14, label %15, label %24

15:                                               ; preds = %12
  %16 = load i32, ptr %3, align 4
  %17 = icmp eq i32 %16, 7
  br i1 %17, label %18, label %20

18:                                               ; preds = %15
  %19 = load ptr, ptr %2, align 8
  store i64 34, ptr %19, align 8
  br label %20

20:                                               ; preds = %18, %15
  br label %21

21:                                               ; preds = %20
  %22 = load i32, ptr %3, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, ptr %3, align 4
  br label %12, !llvm.loop !6

24:                                               ; preds = %12
  br label %39

25:                                               ; preds = %0
  store i32 0, ptr %4, align 4
  br label %26

26:                                               ; preds = %35, %25
  %27 = load i32, ptr %4, align 4
  %28 = icmp slt i32 %27, 16
  br i1 %28, label %29, label %38

29:                                               ; preds = %26
  %30 = load i32, ptr %4, align 4
  %31 = icmp eq i32 %30, 7
  br i1 %31, label %32, label %34

32:                                               ; preds = %29
  %33 = load ptr, ptr %2, align 8
  store i64 27, ptr %33, align 8
  br label %34

34:                                               ; preds = %32, %29
  br label %35

35:                                               ; preds = %34
  %36 = load i32, ptr %4, align 4
  %37 = add nsw i32 %36, 7
  store i32 %37, ptr %4, align 4
  br label %26, !llvm.loop !8

38:                                               ; preds = %26
  br label %39

39:                                               ; preds = %38, %24
  call void @_ZL10pad_writesi(i32 noundef 40)
  store i64 0, ptr %5, align 8
  %40 = load i32, ptr @_ZZ4mainE4tick, align 4
  %41 = srem i32 %40, 37
  %42 = icmp eq i32 %41, 29
  br i1 %42, label %43, label %47

43:                                               ; preds = %39
  %44 = load ptr, ptr %2, align 8
  %45 = load i64, ptr %44, align 8
  %46 = add nsw i64 %45, 1
  store i64 %46, ptr %5, align 8
  br label %51

47:                                               ; preds = %39
  %48 = load ptr, ptr %2, align 8
  %49 = load i64, ptr %48, align 8
  %50 = add nsw i64 %49, 2
  store i64 %50, ptr %5, align 8
  br label %51

51:                                               ; preds = %47, %43
  %52 = load i32, ptr @_ZZ4mainE4tick, align 4
  %53 = add nsw i32 %52, 1
  store i32 %53, ptr @_ZZ4mainE4tick, align 4
  %54 = load ptr, ptr %2, align 8
  call void @free(ptr noundef %54)
  %55 = load i32, ptr %1, align 4
  ret i32 %55
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
