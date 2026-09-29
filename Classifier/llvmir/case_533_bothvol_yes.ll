; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_533_bothvol_yes/case_533_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_533_bothvol_yes/case_533_bothvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4
@_ZL8pad_area = internal global [64 x i32] zeroinitializer, align 4

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [16 x i8], align 1
  %3 = alloca i32, align 4
  %4 = alloca i8, align 1
  store i32 0, ptr %1, align 4
  %5 = load i32, ptr @_ZZ4mainE4tick, align 4
  %6 = srem i32 %5, 31
  %7 = icmp eq i32 %6, 17
  %8 = zext i1 %7 to i64
  %9 = select i1 %7, i32 1, i32 0
  store i32 %9, ptr %3, align 4
  %10 = getelementptr inbounds [16 x i8], ptr %2, i64 0, i64 7
  %11 = load i32, ptr %3, align 4
  call void @_ZL13store_descendPcii(ptr noundef %10, i32 noundef 3, i32 noundef %11)
  call void @_ZL10pad_writesi(i32 noundef 40)
  store i8 0, ptr %4, align 1
  %12 = load i32, ptr @_ZZ4mainE4tick, align 4
  %13 = srem i32 %12, 23
  switch i32 %13, label %26 [
    i32 4, label %14
    i32 5, label %20
  ]

14:                                               ; preds = %0
  %15 = getelementptr inbounds [16 x i8], ptr %2, i64 0, i64 7
  %16 = load i8, ptr %15, align 1
  %17 = sext i8 %16 to i32
  %18 = add nsw i32 %17, 1
  %19 = trunc i32 %18 to i8
  store i8 %19, ptr %4, align 1
  br label %32

20:                                               ; preds = %0
  %21 = getelementptr inbounds [16 x i8], ptr %2, i64 0, i64 7
  %22 = load i8, ptr %21, align 1
  %23 = sext i8 %22 to i32
  %24 = add nsw i32 %23, 2
  %25 = trunc i32 %24 to i8
  store i8 %25, ptr %4, align 1
  br label %32

26:                                               ; preds = %0
  %27 = getelementptr inbounds [16 x i8], ptr %2, i64 0, i64 7
  %28 = load i8, ptr %27, align 1
  %29 = sext i8 %28 to i32
  %30 = add nsw i32 %29, 3
  %31 = trunc i32 %30 to i8
  store i8 %31, ptr %4, align 1
  br label %32

32:                                               ; preds = %26, %20, %14
  %33 = load i32, ptr @_ZZ4mainE4tick, align 4
  %34 = add nsw i32 %33, 1
  store i32 %34, ptr @_ZZ4mainE4tick, align 4
  %35 = load i32, ptr %1, align 4
  ret i32 %35
}

; Function Attrs: mustprogress noinline ssp uwtable(sync)
define internal void @_ZL13store_descendPcii(ptr noundef %0, i32 noundef %1, i32 noundef %2) #1 {
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %7 = load i32, ptr %6, align 4
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %9, label %14

9:                                                ; preds = %3
  %10 = load i32, ptr %5, align 4
  %11 = icmp eq i32 %10, 1
  br i1 %11, label %12, label %14

12:                                               ; preds = %9
  %13 = load ptr, ptr %4, align 8
  store i8 77, ptr %13, align 1
  br label %24

14:                                               ; preds = %9, %3
  %15 = load i32, ptr %5, align 4
  %16 = icmp eq i32 %15, 0
  br i1 %16, label %17, label %19

17:                                               ; preds = %14
  %18 = load ptr, ptr %4, align 8
  store i8 70, ptr %18, align 1
  br label %24

19:                                               ; preds = %14
  %20 = load ptr, ptr %4, align 8
  %21 = load i32, ptr %5, align 4
  %22 = sub nsw i32 %21, 1
  %23 = load i32, ptr %6, align 4
  call void @_ZL13store_descendPcii(ptr noundef %20, i32 noundef %22, i32 noundef %23)
  br label %24

24:                                               ; preds = %19, %17, %12
  ret void
}

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
  br label %10, !llvm.loop !6

23:                                               ; preds = %10
  br label %24

24:                                               ; preds = %23
  %25 = load i32, ptr %3, align 4
  %26 = add nsw i32 %25, 1
  store i32 %26, ptr %3, align 4
  br label %5, !llvm.loop !8

27:                                               ; preds = %5
  ret void
}

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { mustprogress noinline ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { mustprogress noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }

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
