; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_599_bothvol_yes/case_599_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_599_bothvol_yes/case_599_bothvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [16 x i16], align 2
  %3 = alloca i32, align 4
  %4 = alloca i16, align 2
  store i32 0, ptr %1, align 4
  %5 = call i32 @rand()
  %6 = srem i32 %5, 16
  store i32 %6, ptr %3, align 4
  %7 = load i32, ptr %3, align 4
  %8 = sext i32 %7 to i64
  %9 = getelementptr inbounds [16 x i16], ptr %2, i64 0, i64 %8
  store i16 47, ptr %9, align 2
  %10 = load i32, ptr @_ZZ4mainE4tick, align 4
  %11 = srem i32 %10, 19
  %12 = icmp eq i32 %11, 12
  br i1 %12, label %13, label %17

13:                                               ; preds = %0
  %14 = load i32, ptr %3, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds [16 x i16], ptr %2, i64 0, i64 %15
  store i16 54, ptr %16, align 2
  br label %17

17:                                               ; preds = %13, %0
  %18 = load i32, ptr %3, align 4
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds [16 x i16], ptr %2, i64 0, i64 %19
  %21 = load i16, ptr %20, align 2
  store i16 %21, ptr %4, align 2
  %22 = load i32, ptr @_ZZ4mainE4tick, align 4
  %23 = srem i32 %22, 29
  %24 = icmp eq i32 %23, 19
  br i1 %24, label %25, label %35

25:                                               ; preds = %17
  %26 = load i32, ptr %3, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds [16 x i16], ptr %2, i64 0, i64 %27
  %29 = load i16, ptr %28, align 2
  %30 = sext i16 %29 to i32
  %31 = load i16, ptr %4, align 2
  %32 = sext i16 %31 to i32
  %33 = add nsw i32 %32, %30
  %34 = trunc i32 %33 to i16
  store i16 %34, ptr %4, align 2
  br label %35

35:                                               ; preds = %25, %17
  %36 = load i32, ptr @_ZZ4mainE4tick, align 4
  %37 = add nsw i32 %36, 1
  store i32 %37, ptr @_ZZ4mainE4tick, align 4
  %38 = load i32, ptr %1, align 4
  ret i32 %38
}

declare i32 @rand() #1

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 16.0.6"}
