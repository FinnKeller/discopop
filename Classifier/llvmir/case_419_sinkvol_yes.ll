; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_419_sinkvol_yes/case_419_sinkvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_419_sinkvol_yes/case_419_sinkvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i64, align 8
  store i32 0, ptr %1, align 4
  %6 = call noalias noundef nonnull ptr @_Znwm(i64 noundef 8) #4
  store i64 0, ptr %6, align 8
  store ptr %6, ptr %2, align 8
  %7 = load i32, ptr @_ZZ4mainE4tick, align 4
  %8 = srem i32 %7, 29
  %9 = icmp eq i32 %8, 9
  br i1 %9, label %10, label %24

10:                                               ; preds = %0
  store i32 0, ptr %3, align 4
  br label %11

11:                                               ; preds = %20, %10
  %12 = load i32, ptr %3, align 4
  %13 = icmp slt i32 %12, 16
  br i1 %13, label %14, label %23

14:                                               ; preds = %11
  %15 = load i32, ptr %3, align 4
  %16 = icmp eq i32 %15, 7
  br i1 %16, label %17, label %19

17:                                               ; preds = %14
  %18 = load ptr, ptr %2, align 8
  store i64 40, ptr %18, align 8
  br label %19

19:                                               ; preds = %17, %14
  br label %20

20:                                               ; preds = %19
  %21 = load i32, ptr %3, align 4
  %22 = add nsw i32 %21, 1
  store i32 %22, ptr %3, align 4
  br label %11, !llvm.loop !6

23:                                               ; preds = %11
  br label %38

24:                                               ; preds = %0
  store i32 0, ptr %4, align 4
  br label %25

25:                                               ; preds = %34, %24
  %26 = load i32, ptr %4, align 4
  %27 = icmp slt i32 %26, 16
  br i1 %27, label %28, label %37

28:                                               ; preds = %25
  %29 = load i32, ptr %4, align 4
  %30 = icmp eq i32 %29, 7
  br i1 %30, label %31, label %33

31:                                               ; preds = %28
  %32 = load ptr, ptr %2, align 8
  store i64 33, ptr %32, align 8
  br label %33

33:                                               ; preds = %31, %28
  br label %34

34:                                               ; preds = %33
  %35 = load i32, ptr %4, align 4
  %36 = add nsw i32 %35, 7
  store i32 %36, ptr %4, align 4
  br label %25, !llvm.loop !8

37:                                               ; preds = %25
  br label %38

38:                                               ; preds = %37, %23
  %39 = load ptr, ptr %2, align 8
  %40 = call noundef i64 @_ZL10load_outerPKx(ptr noundef %39)
  store i64 %40, ptr %5, align 8
  %41 = load i32, ptr @_ZZ4mainE4tick, align 4
  %42 = add nsw i32 %41, 1
  store i32 %42, ptr @_ZZ4mainE4tick, align 4
  %43 = load i32, ptr %1, align 4
  ret i32 %43
}

; Function Attrs: nobuiltin allocsize(0)
declare noundef nonnull ptr @_Znwm(i64 noundef) #1

; Function Attrs: mustprogress noinline ssp uwtable(sync)
define internal noundef i64 @_ZL10load_outerPKx(ptr noundef %0) #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef i64 @_ZL10load_innerPKx(ptr noundef %3)
  ret i64 %4
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal noundef i64 @_ZL10load_innerPKx(ptr noundef %0) #3 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = load i64, ptr %3, align 8
  ret i64 %4
}

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { nobuiltin allocsize(0) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { mustprogress noinline ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { mustprogress noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #4 = { builtin allocsize(0) }

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
