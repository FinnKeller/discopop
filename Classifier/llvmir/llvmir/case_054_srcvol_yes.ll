; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_054_srcvol_yes/case_054_srcvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_054_srcvol_yes/case_054_srcvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse nounwind ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %2, align 4
  store i32 51, ptr %2, align 4
  %5 = load i32, ptr @_ZZ4mainE4tick, align 4
  %6 = srem i32 %5, 31
  store i32 %6, ptr %3, align 4
  store i32 0, ptr %4, align 4
  %7 = load i32, ptr %3, align 4
  %8 = icmp slt i32 %7, 16
  br i1 %8, label %9, label %12

9:                                                ; preds = %0
  %10 = load i32, ptr %2, align 4
  %11 = add nsw i32 %10, 1
  store i32 %11, ptr %4, align 4
  br label %36

12:                                               ; preds = %0
  %13 = load i32, ptr %3, align 4
  %14 = icmp slt i32 %13, 24
  br i1 %14, label %15, label %18

15:                                               ; preds = %12
  %16 = load i32, ptr %2, align 4
  %17 = add nsw i32 %16, 2
  store i32 %17, ptr %4, align 4
  br label %35

18:                                               ; preds = %12
  %19 = load i32, ptr %3, align 4
  %20 = icmp slt i32 %19, 28
  br i1 %20, label %21, label %24

21:                                               ; preds = %18
  %22 = load i32, ptr %2, align 4
  %23 = add nsw i32 %22, 3
  store i32 %23, ptr %4, align 4
  br label %34

24:                                               ; preds = %18
  %25 = load i32, ptr %3, align 4
  %26 = icmp slt i32 %25, 30
  br i1 %26, label %27, label %30

27:                                               ; preds = %24
  %28 = load i32, ptr %2, align 4
  %29 = add nsw i32 %28, 4
  store i32 %29, ptr %4, align 4
  br label %33

30:                                               ; preds = %24
  %31 = load i32, ptr %2, align 4
  %32 = add nsw i32 %31, 5
  store i32 %32, ptr %4, align 4
  br label %33

33:                                               ; preds = %30, %27
  br label %34

34:                                               ; preds = %33, %21
  br label %35

35:                                               ; preds = %34, %15
  br label %36

36:                                               ; preds = %35, %9
  %37 = load i32, ptr @_ZZ4mainE4tick, align 4
  %38 = add nsw i32 %37, 1
  store i32 %38, ptr @_ZZ4mainE4tick, align 4
  %39 = load i32, ptr %1, align 4
  ret i32 %39
}

attributes #0 = { mustprogress noinline norecurse nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 16.0.6"}
