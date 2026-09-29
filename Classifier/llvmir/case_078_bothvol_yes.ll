; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_078_bothvol_yes/case_078_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_078_bothvol_yes/case_078_bothvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

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
  store ptr %2, ptr %5, align 8
  %8 = getelementptr inbounds ptr, ptr %5, i64 1
  store ptr %3, ptr %8, align 8
  %9 = getelementptr inbounds ptr, ptr %5, i64 2
  store ptr %4, ptr %9, align 8
  %10 = call i32 @rand()
  %11 = srem i32 %10, 3
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds [3 x ptr], ptr %5, i64 0, i64 %12
  %14 = load ptr, ptr %13, align 8
  store ptr %14, ptr %6, align 8
  store i32 0, ptr %7, align 4
  %15 = call i32 @rand()
  %16 = srem i32 %15, 3
  switch i32 %16, label %24 [
    i32 0, label %17
    i32 1, label %20
  ]

17:                                               ; preds = %0
  %18 = load ptr, ptr %6, align 8
  %19 = load i32, ptr %18, align 4
  store i32 %19, ptr %7, align 4
  br label %28

20:                                               ; preds = %0
  %21 = load ptr, ptr %6, align 8
  %22 = load i32, ptr %21, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, ptr %7, align 4
  br label %28

24:                                               ; preds = %0
  %25 = load ptr, ptr %6, align 8
  %26 = load i32, ptr %25, align 4
  %27 = mul nsw i32 %26, 2
  store i32 %27, ptr %7, align 4
  br label %28

28:                                               ; preds = %24, %20, %17
  %29 = load i32, ptr %1, align 4
  ret i32 %29
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
