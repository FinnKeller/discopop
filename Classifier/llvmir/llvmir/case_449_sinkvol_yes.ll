; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_449_sinkvol_yes/case_449_sinkvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_449_sinkvol_yes/case_449_sinkvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse nounwind ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %2, align 4
  %5 = load i32, ptr @_ZZ4mainE4tick, align 4
  %6 = srem i32 %5, 41
  switch i32 %6, label %9 [
    i32 13, label %7
    i32 14, label %8
  ]

7:                                                ; preds = %0
  store i32 48, ptr %2, align 4
  br label %10

8:                                                ; preds = %0
  store i32 54, ptr %2, align 4
  br label %10

9:                                                ; preds = %0
  store i32 41, ptr %2, align 4
  br label %10

10:                                               ; preds = %9, %8, %7
  store ptr %2, ptr %3, align 8
  %11 = load ptr, ptr %3, align 8
  %12 = load i32, ptr %11, align 4
  store i32 %12, ptr %4, align 4
  %13 = load i32, ptr @_ZZ4mainE4tick, align 4
  %14 = add nsw i32 %13, 1
  store i32 %14, ptr @_ZZ4mainE4tick, align 4
  %15 = load i32, ptr %1, align 4
  ret i32 %15
}

attributes #0 = { mustprogress noinline norecurse nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 16.0.6"}
