; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_472_srcvol_yes/case_472_srcvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_472_srcvol_yes/case_472_srcvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4
@_ZL8pad_area = internal global [32 x i32] zeroinitializer, align 4

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [16 x i16], align 2
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i16, align 2
  store i32 0, ptr %1, align 4
  %9 = getelementptr inbounds [16 x i16], ptr %2, i64 0, i64 0
  %10 = getelementptr inbounds i16, ptr %9, i64 5
  store ptr %10, ptr %3, align 8
  %11 = call noundef i32 @_ZL9pad_readsi(i32 noundef 8)
  store i32 %11, ptr %4, align 4
  %12 = load ptr, ptr %3, align 8
  store ptr %12, ptr %5, align 8
  %13 = load ptr, ptr %5, align 8
  store ptr %13, ptr %6, align 8
  %14 = load ptr, ptr %6, align 8
  store ptr %14, ptr %7, align 8
  %15 = load ptr, ptr %7, align 8
  store i16 48, ptr %15, align 2
  store i16 0, ptr %8, align 2
  %16 = load i32, ptr @_ZZ4mainE4tick, align 4
  %17 = srem i32 %16, 41
  switch i32 %17, label %30 [
    i32 23, label %18
    i32 24, label %24
  ]

18:                                               ; preds = %0
  %19 = load ptr, ptr %3, align 8
  %20 = load i16, ptr %19, align 2
  %21 = sext i16 %20 to i32
  %22 = add nsw i32 %21, 1
  %23 = trunc i32 %22 to i16
  store i16 %23, ptr %8, align 2
  br label %36

24:                                               ; preds = %0
  %25 = load ptr, ptr %3, align 8
  %26 = load i16, ptr %25, align 2
  %27 = sext i16 %26 to i32
  %28 = add nsw i32 %27, 2
  %29 = trunc i32 %28 to i16
  store i16 %29, ptr %8, align 2
  br label %36

30:                                               ; preds = %0
  %31 = load ptr, ptr %3, align 8
  %32 = load i16, ptr %31, align 2
  %33 = sext i16 %32 to i32
  %34 = add nsw i32 %33, 3
  %35 = trunc i32 %34 to i16
  store i16 %35, ptr %8, align 2
  br label %36

36:                                               ; preds = %30, %24, %18
  %37 = load i32, ptr @_ZZ4mainE4tick, align 4
  %38 = add nsw i32 %37, 1
  store i32 %38, ptr @_ZZ4mainE4tick, align 4
  %39 = load i32, ptr %1, align 4
  ret i32 %39
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
  br label %11, !llvm.loop !6

24:                                               ; preds = %11
  br label %25

25:                                               ; preds = %24
  %26 = load i32, ptr %4, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, ptr %4, align 4
  br label %6, !llvm.loop !8

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
