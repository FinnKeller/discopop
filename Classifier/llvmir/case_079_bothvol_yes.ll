; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_079_bothvol_yes/case_079_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_079_bothvol_yes/case_079_bothvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse nounwind ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %6 = load i32, ptr @_ZZ4mainE4tick, align 4
  %7 = srem i32 %6, 23
  store i32 %7, ptr %2, align 4
  %8 = load i32, ptr @_ZZ4mainE4tick, align 4
  %9 = mul nsw i32 %8, 5
  %10 = srem i32 %9, 19
  store i32 %10, ptr %3, align 4
  store i32 0, ptr %4, align 4
  %11 = load i32, ptr %2, align 4
  %12 = icmp slt i32 %11, 12
  br i1 %12, label %13, label %14

13:                                               ; preds = %0
  store i32 1, ptr %4, align 4
  br label %25

14:                                               ; preds = %0
  %15 = load i32, ptr %2, align 4
  %16 = icmp slt i32 %15, 18
  br i1 %16, label %17, label %18

17:                                               ; preds = %14
  store i32 2, ptr %4, align 4
  br label %24

18:                                               ; preds = %14
  %19 = load i32, ptr %2, align 4
  %20 = icmp slt i32 %19, 22
  br i1 %20, label %21, label %22

21:                                               ; preds = %18
  store i32 3, ptr %4, align 4
  br label %23

22:                                               ; preds = %18
  store i32 4, ptr %4, align 4
  br label %23

23:                                               ; preds = %22, %21
  br label %24

24:                                               ; preds = %23, %17
  br label %25

25:                                               ; preds = %24, %13
  store i32 0, ptr %5, align 4
  %26 = load i32, ptr %3, align 4
  %27 = icmp slt i32 %26, 10
  br i1 %27, label %28, label %31

28:                                               ; preds = %25
  %29 = load i32, ptr %4, align 4
  %30 = add nsw i32 %29, 1
  store i32 %30, ptr %5, align 4
  br label %48

31:                                               ; preds = %25
  %32 = load i32, ptr %3, align 4
  %33 = icmp slt i32 %32, 15
  br i1 %33, label %34, label %37

34:                                               ; preds = %31
  %35 = load i32, ptr %4, align 4
  %36 = add nsw i32 %35, 2
  store i32 %36, ptr %5, align 4
  br label %47

37:                                               ; preds = %31
  %38 = load i32, ptr %3, align 4
  %39 = icmp slt i32 %38, 18
  br i1 %39, label %40, label %43

40:                                               ; preds = %37
  %41 = load i32, ptr %4, align 4
  %42 = add nsw i32 %41, 3
  store i32 %42, ptr %5, align 4
  br label %46

43:                                               ; preds = %37
  %44 = load i32, ptr %4, align 4
  %45 = add nsw i32 %44, 4
  store i32 %45, ptr %5, align 4
  br label %46

46:                                               ; preds = %43, %40
  br label %47

47:                                               ; preds = %46, %34
  br label %48

48:                                               ; preds = %47, %28
  %49 = load i32, ptr @_ZZ4mainE4tick, align 4
  %50 = add nsw i32 %49, 1
  store i32 %50, ptr @_ZZ4mainE4tick, align 4
  %51 = load i32, ptr %1, align 4
  ret i32 %51
}

attributes #0 = { mustprogress noinline norecurse nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 5]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Homebrew clang version 21.1.8"}
