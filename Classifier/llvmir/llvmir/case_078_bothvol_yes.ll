; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_078_bothvol_yes/case_078_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_078_bothvol_yes/case_078_bothvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca [3 x ptr], align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 11, ptr %2, align 4
  store i32 22, ptr %3, align 4
  store i32 33, ptr %4, align 4
  %8 = getelementptr inbounds [3 x ptr], ptr %5, i64 0, i64 0
  store ptr %2, ptr %8, align 8
  %9 = getelementptr inbounds ptr, ptr %8, i64 1
  store ptr %3, ptr %9, align 8
  %10 = getelementptr inbounds ptr, ptr %9, i64 1
  store ptr %4, ptr %10, align 8
  %11 = call i32 @rand()
  %12 = srem i32 %11, 3
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds [3 x ptr], ptr %5, i64 0, i64 %13
  %15 = load ptr, ptr %14, align 8
  store ptr %15, ptr %6, align 8
  store i32 0, ptr %7, align 4
  %16 = call i32 @rand()
  %17 = srem i32 %16, 3
  switch i32 %17, label %25 [
    i32 0, label %18
    i32 1, label %21
  ]

18:                                               ; preds = %0
  %19 = load ptr, ptr %6, align 8
  %20 = load i32, ptr %19, align 4
  store i32 %20, ptr %7, align 4
  br label %29

21:                                               ; preds = %0
  %22 = load ptr, ptr %6, align 8
  %23 = load i32, ptr %22, align 4
  %24 = add nsw i32 %23, 1
  store i32 %24, ptr %7, align 4
  br label %29

25:                                               ; preds = %0
  %26 = load ptr, ptr %6, align 8
  %27 = load i32, ptr %26, align 4
  %28 = mul nsw i32 %27, 2
  store i32 %28, ptr %7, align 4
  br label %29

29:                                               ; preds = %25, %21, %18
  %30 = load i32, ptr %1, align 4
  ret i32 %30
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
