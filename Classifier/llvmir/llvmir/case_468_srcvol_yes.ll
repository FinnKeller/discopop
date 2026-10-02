; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_468_srcvol_yes/case_468_srcvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_468_srcvol_yes/case_468_srcvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse nounwind ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [16 x i32], align 4
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %7 = getelementptr inbounds [16 x i32], ptr %2, i64 0, i64 7
  store ptr %7, ptr %3, align 8
  %8 = load ptr, ptr %3, align 8
  store ptr %8, ptr %4, align 8
  %9 = load ptr, ptr %4, align 8
  store ptr %9, ptr %5, align 8
  %10 = load ptr, ptr %5, align 8
  store i32 44, ptr %10, align 4
  %11 = getelementptr inbounds [16 x i32], ptr %2, i64 0, i64 7
  %12 = load i32, ptr %11, align 4
  store i32 %12, ptr %6, align 4
  %13 = load i32, ptr @_ZZ4mainE4tick, align 4
  %14 = srem i32 %13, 31
  %15 = icmp eq i32 %14, 7
  br i1 %15, label %16, label %21

16:                                               ; preds = %0
  %17 = getelementptr inbounds [16 x i32], ptr %2, i64 0, i64 7
  %18 = load i32, ptr %17, align 4
  %19 = load i32, ptr %6, align 4
  %20 = add i32 %19, %18
  store i32 %20, ptr %6, align 4
  br label %21

21:                                               ; preds = %16, %0
  %22 = load i32, ptr @_ZZ4mainE4tick, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, ptr @_ZZ4mainE4tick, align 4
  %24 = load i32, ptr %1, align 4
  ret i32 %24
}

attributes #0 = { mustprogress noinline norecurse nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 16.0.6"}
