; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_587_bothvol_yes/case_587_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_587_bothvol_yes/case_587_bothvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse nounwind ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [16 x i64], align 8
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  store i32 0, ptr %1, align 4
  %5 = getelementptr inbounds [16 x i64], ptr %2, i64 0, i64 0
  %6 = getelementptr inbounds i64, ptr %5, i64 5
  store ptr %6, ptr %3, align 8
  %7 = load ptr, ptr %3, align 8
  store i64 33, ptr %7, align 8
  %8 = load i32, ptr @_ZZ4mainE4tick, align 4
  %9 = srem i32 %8, 41
  %10 = icmp eq i32 %9, 23
  br i1 %10, label %11, label %13

11:                                               ; preds = %0
  %12 = load ptr, ptr %3, align 8
  store i64 40, ptr %12, align 8
  br label %13

13:                                               ; preds = %11, %0
  store i64 0, ptr %4, align 8
  %14 = load i32, ptr @_ZZ4mainE4tick, align 4
  %15 = srem i32 %14, 29
  %16 = icmp eq i32 %15, 19
  br i1 %16, label %17, label %21

17:                                               ; preds = %13
  %18 = load ptr, ptr %3, align 8
  %19 = load i64, ptr %18, align 8
  %20 = add nsw i64 %19, 1
  store i64 %20, ptr %4, align 8
  br label %25

21:                                               ; preds = %13
  %22 = load ptr, ptr %3, align 8
  %23 = load i64, ptr %22, align 8
  %24 = add nsw i64 %23, 2
  store i64 %24, ptr %4, align 8
  br label %25

25:                                               ; preds = %21, %17
  %26 = load i32, ptr @_ZZ4mainE4tick, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, ptr @_ZZ4mainE4tick, align 4
  %28 = load i32, ptr %1, align 4
  ret i32 %28
}

attributes #0 = { mustprogress noinline norecurse nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 16.0.6"}
