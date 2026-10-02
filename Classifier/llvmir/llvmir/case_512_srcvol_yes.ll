; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_512_srcvol_yes/case_512_srcvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_512_srcvol_yes/case_512_srcvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse nounwind ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [16 x i16], align 2
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i16, align 2
  store i32 0, ptr %1, align 4
  %7 = getelementptr inbounds [16 x i16], ptr %2, i64 0, i64 7
  store ptr %7, ptr %3, align 8
  %8 = load ptr, ptr %3, align 8
  store ptr %8, ptr %4, align 8
  %9 = load ptr, ptr %4, align 8
  store ptr %9, ptr %5, align 8
  %10 = load ptr, ptr %5, align 8
  store i16 43, ptr %10, align 2
  store i16 0, ptr %6, align 2
  %11 = load i32, ptr @_ZZ4mainE4tick, align 4
  %12 = srem i32 %11, 23
  switch i32 %12, label %25 [
    i32 11, label %13
    i32 12, label %19
  ]

13:                                               ; preds = %0
  %14 = getelementptr inbounds [16 x i16], ptr %2, i64 0, i64 7
  %15 = load i16, ptr %14, align 2
  %16 = sext i16 %15 to i32
  %17 = add nsw i32 %16, 1
  %18 = trunc i32 %17 to i16
  store i16 %18, ptr %6, align 2
  br label %31

19:                                               ; preds = %0
  %20 = getelementptr inbounds [16 x i16], ptr %2, i64 0, i64 7
  %21 = load i16, ptr %20, align 2
  %22 = sext i16 %21 to i32
  %23 = add nsw i32 %22, 2
  %24 = trunc i32 %23 to i16
  store i16 %24, ptr %6, align 2
  br label %31

25:                                               ; preds = %0
  %26 = getelementptr inbounds [16 x i16], ptr %2, i64 0, i64 7
  %27 = load i16, ptr %26, align 2
  %28 = sext i16 %27 to i32
  %29 = add nsw i32 %28, 3
  %30 = trunc i32 %29 to i16
  store i16 %30, ptr %6, align 2
  br label %31

31:                                               ; preds = %25, %19, %13
  %32 = load i32, ptr @_ZZ4mainE4tick, align 4
  %33 = add nsw i32 %32, 1
  store i32 %33, ptr @_ZZ4mainE4tick, align 4
  %34 = load i32, ptr %1, align 4
  ret i32 %34
}

attributes #0 = { mustprogress noinline norecurse nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 16.0.6"}
