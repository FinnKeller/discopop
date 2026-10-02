; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_413_sinkvol_yes/case_413_sinkvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_413_sinkvol_yes/case_413_sinkvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse nounwind ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [16 x i32], align 4
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %5 = getelementptr inbounds [16 x i32], ptr %2, i64 0, i64 0
  %6 = getelementptr inbounds i32, ptr %5, i64 5
  store ptr %6, ptr %3, align 8
  %7 = load i32, ptr @_ZZ4mainE4tick, align 4
  %8 = srem i32 %7, 41
  %9 = icmp eq i32 %8, 23
  br i1 %9, label %10, label %12

10:                                               ; preds = %0
  %11 = load ptr, ptr %3, align 8
  store i32 58, ptr %11, align 4
  br label %14

12:                                               ; preds = %0
  %13 = load ptr, ptr %3, align 8
  store i32 51, ptr %13, align 4
  br label %14

14:                                               ; preds = %12, %10
  %15 = load ptr, ptr %3, align 8
  %16 = load i32, ptr %15, align 4
  store i32 %16, ptr %4, align 4
  %17 = load i32, ptr @_ZZ4mainE4tick, align 4
  %18 = add nsw i32 %17, 1
  store i32 %18, ptr @_ZZ4mainE4tick, align 4
  %19 = load i32, ptr %1, align 4
  ret i32 %19
}

attributes #0 = { mustprogress noinline norecurse nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 16.0.6"}
