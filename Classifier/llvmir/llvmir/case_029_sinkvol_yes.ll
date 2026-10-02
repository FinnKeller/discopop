; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_029_sinkvol_yes/case_029_sinkvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_029_sinkvol_yes/case_029_sinkvol_yes.cpp"
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
  %5 = load i32, ptr @_ZZ4mainE4tick, align 4
  %6 = srem i32 %5, 31
  store i32 %6, ptr %3, align 4
  %7 = load i32, ptr %3, align 4
  %8 = icmp slt i32 %7, 16
  br i1 %8, label %9, label %10

9:                                                ; preds = %0
  store i32 1, ptr %2, align 4
  br label %26

10:                                               ; preds = %0
  %11 = load i32, ptr %3, align 4
  %12 = icmp slt i32 %11, 24
  br i1 %12, label %13, label %14

13:                                               ; preds = %10
  store i32 2, ptr %2, align 4
  br label %25

14:                                               ; preds = %10
  %15 = load i32, ptr %3, align 4
  %16 = icmp slt i32 %15, 28
  br i1 %16, label %17, label %18

17:                                               ; preds = %14
  store i32 3, ptr %2, align 4
  br label %24

18:                                               ; preds = %14
  %19 = load i32, ptr %3, align 4
  %20 = icmp slt i32 %19, 30
  br i1 %20, label %21, label %22

21:                                               ; preds = %18
  store i32 4, ptr %2, align 4
  br label %23

22:                                               ; preds = %18
  store i32 5, ptr %2, align 4
  br label %23

23:                                               ; preds = %22, %21
  br label %24

24:                                               ; preds = %23, %17
  br label %25

25:                                               ; preds = %24, %13
  br label %26

26:                                               ; preds = %25, %9
  %27 = load i32, ptr %2, align 4
  store i32 %27, ptr %4, align 4
  %28 = load i32, ptr @_ZZ4mainE4tick, align 4
  %29 = add nsw i32 %28, 1
  store i32 %29, ptr @_ZZ4mainE4tick, align 4
  %30 = load i32, ptr %1, align 4
  ret i32 %30
}

attributes #0 = { mustprogress noinline norecurse nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 16.0.6"}
