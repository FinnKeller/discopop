; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_026_sinkvol_yes/case_026_sinkvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_026_sinkvol_yes/case_026_sinkvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca [8 x ptr], align 8
  %10 = alloca ptr, align 8
  %11 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 1, ptr %2, align 4
  store i32 2, ptr %3, align 4
  store i32 3, ptr %4, align 4
  store i32 4, ptr %5, align 4
  store i32 5, ptr %6, align 4
  store i32 6, ptr %7, align 4
  store i32 7, ptr %8, align 4
  %12 = getelementptr inbounds [8 x ptr], ptr %9, i64 0, i64 0
  store ptr %1, ptr %12, align 8
  %13 = getelementptr inbounds ptr, ptr %12, i64 1
  store ptr %2, ptr %13, align 8
  %14 = getelementptr inbounds ptr, ptr %13, i64 1
  store ptr %3, ptr %14, align 8
  %15 = getelementptr inbounds ptr, ptr %14, i64 1
  store ptr %4, ptr %15, align 8
  %16 = getelementptr inbounds ptr, ptr %15, i64 1
  store ptr %5, ptr %16, align 8
  %17 = getelementptr inbounds ptr, ptr %16, i64 1
  store ptr %6, ptr %17, align 8
  %18 = getelementptr inbounds ptr, ptr %17, i64 1
  store ptr %7, ptr %18, align 8
  %19 = getelementptr inbounds ptr, ptr %18, i64 1
  store ptr %8, ptr %19, align 8
  %20 = call i32 @rand()
  %21 = srem i32 %20, 8
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds [8 x ptr], ptr %9, i64 0, i64 %22
  %24 = load ptr, ptr %23, align 8
  store ptr %24, ptr %10, align 8
  %25 = load ptr, ptr %10, align 8
  %26 = load i32, ptr %25, align 4
  store i32 %26, ptr %11, align 4
  ret i32 0
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
