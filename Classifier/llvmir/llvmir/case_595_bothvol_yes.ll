; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_595_bothvol_yes/case_595_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_595_bothvol_yes/case_595_bothvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4
@_ZZ4mainE4cell = internal global i64 0, align 8

; Function Attrs: mustprogress noinline norecurse nounwind ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  store i32 0, ptr %1, align 4
  store i64 0, ptr @_ZZ4mainE4cell, align 8
  %3 = load i32, ptr @_ZZ4mainE4tick, align 4
  %4 = srem i32 %3, 31
  %5 = icmp eq i32 %4, 17
  br i1 %5, label %6, label %7

6:                                                ; preds = %0
  store i64 35, ptr @_ZZ4mainE4cell, align 8
  br label %8

7:                                                ; preds = %0
  store i64 28, ptr @_ZZ4mainE4cell, align 8
  br label %8

8:                                                ; preds = %7, %6
  %9 = load i64, ptr @_ZZ4mainE4cell, align 8
  store i64 %9, ptr %2, align 8
  %10 = load i32, ptr @_ZZ4mainE4tick, align 4
  %11 = srem i32 %10, 23
  %12 = icmp eq i32 %11, 4
  br i1 %12, label %13, label %17

13:                                               ; preds = %8
  %14 = load i64, ptr @_ZZ4mainE4cell, align 8
  %15 = load i64, ptr %2, align 8
  %16 = add nsw i64 %15, %14
  store i64 %16, ptr %2, align 8
  br label %17

17:                                               ; preds = %13, %8
  %18 = load i32, ptr @_ZZ4mainE4tick, align 4
  %19 = add nsw i32 %18, 1
  store i32 %19, ptr @_ZZ4mainE4tick, align 4
  %20 = load i32, ptr %1, align 4
  ret i32 %20
}

attributes #0 = { mustprogress noinline norecurse nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 16.0.6"}
