; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_026_sinkvol_yes/case_026_sinkvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_026_sinkvol_yes/case_026_sinkvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

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
  store ptr %1, ptr %9, align 8
  %12 = getelementptr inbounds ptr, ptr %9, i64 1
  store ptr %2, ptr %12, align 8
  %13 = getelementptr inbounds ptr, ptr %9, i64 2
  store ptr %3, ptr %13, align 8
  %14 = getelementptr inbounds ptr, ptr %9, i64 3
  store ptr %4, ptr %14, align 8
  %15 = getelementptr inbounds ptr, ptr %9, i64 4
  store ptr %5, ptr %15, align 8
  %16 = getelementptr inbounds ptr, ptr %9, i64 5
  store ptr %6, ptr %16, align 8
  %17 = getelementptr inbounds ptr, ptr %9, i64 6
  store ptr %7, ptr %17, align 8
  %18 = getelementptr inbounds ptr, ptr %9, i64 7
  store ptr %8, ptr %18, align 8
  %19 = call i32 @rand()
  %20 = srem i32 %19, 8
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds [8 x ptr], ptr %9, i64 0, i64 %21
  %23 = load ptr, ptr %22, align 8
  store ptr %23, ptr %10, align 8
  %24 = load ptr, ptr %10, align 8
  %25 = load i32, ptr %24, align 4
  store i32 %25, ptr %11, align 4
  ret i32 0
}

declare i32 @rand() #1

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 5]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Homebrew clang version 21.1.8"}
