; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_444_sinkvol_yes/case_444_sinkvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_444_sinkvol_yes/case_444_sinkvol_yes.cpp"
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
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %7 = call noalias noundef nonnull ptr @_Znwm(i64 noundef 4) #4
  store i32 0, ptr %7, align 4
  store ptr %7, ptr %2, align 8
  %8 = load i32, ptr @_ZZ4mainE4tick, align 4
  %9 = srem i32 %8, 31
  %10 = icmp eq i32 %9, 17
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
  store i32 32, ptr %19, align 4
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
  store i32 25, ptr %33, align 4
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
  %40 = call noundef i32 @_ZL9pad_readsi(i32 noundef 40)
  store i32 %40, ptr %5, align 4
  %41 = load ptr, ptr %2, align 8
  %42 = call noundef i32 @_ZL12load_genericIjET_PKS0_(ptr noundef %41)
  store i32 %42, ptr %6, align 4
  %43 = load i32, ptr @_ZZ4mainE4tick, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, ptr @_ZZ4mainE4tick, align 4
  %45 = load ptr, ptr %2, align 8
  %46 = icmp eq ptr %45, null
  br i1 %46, label %48, label %47

47:                                               ; preds = %39
  call void @_ZdlPvm(ptr noundef %45, i64 noundef 4) #5
  br label %48

48:                                               ; preds = %47, %39
  %49 = load i32, ptr %1, align 4
  ret i32 %49
}

; Function Attrs: nobuiltin allocsize(0)
declare noundef nonnull ptr @_Znwm(i64 noundef) #1

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal noundef i32 @_ZL9pad_readsi(i32 noundef %0) #2 {
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

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal noundef i32 @_ZL12load_genericIjET_PKS0_(ptr noundef %0) #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = load i32, ptr %3, align 4
  ret i32 %4
}

; Function Attrs: nobuiltin nounwind
declare void @_ZdlPvm(ptr noundef, i64 noundef) #3

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { nobuiltin allocsize(0) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { mustprogress noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { nobuiltin nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #4 = { builtin allocsize(0) }
attributes #5 = { builtin nounwind }

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
