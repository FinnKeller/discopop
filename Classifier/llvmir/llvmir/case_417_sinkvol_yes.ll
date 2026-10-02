; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_417_sinkvol_yes/case_417_sinkvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_417_sinkvol_yes/case_417_sinkvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse nounwind ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [16 x i64], align 8
  %3 = alloca i64, align 8
  store i32 0, ptr %1, align 4
  %4 = load i32, ptr @_ZZ4mainE4tick, align 4
  %5 = srem i32 %4, 41
  %6 = icmp eq i32 %5, 23
  br i1 %6, label %7, label %9

7:                                                ; preds = %0
  %8 = getelementptr inbounds [16 x i64], ptr %2, i64 0, i64 7
  store i64 52, ptr %8, align 8
  br label %11

9:                                                ; preds = %0
  %10 = getelementptr inbounds [16 x i64], ptr %2, i64 0, i64 7
  store i64 45, ptr %10, align 8
  br label %11

11:                                               ; preds = %9, %7
  %12 = getelementptr inbounds [16 x i64], ptr %2, i64 0, i64 7
  %13 = load i64, ptr %12, align 8
  store i64 %13, ptr %3, align 8
  %14 = load i32, ptr @_ZZ4mainE4tick, align 4
  %15 = add nsw i32 %14, 1
  store i32 %15, ptr @_ZZ4mainE4tick, align 4
  %16 = load i32, ptr %1, align 4
  ret i32 %16
}

attributes #0 = { mustprogress noinline norecurse nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 16.0.6"}
