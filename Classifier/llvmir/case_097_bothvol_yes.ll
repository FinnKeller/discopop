; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_097_bothvol_yes/case_097_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_097_bothvol_yes/case_097_bothvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %2, align 4
  store ptr %2, ptr %3, align 8
  store ptr %3, ptr %4, align 8
  store ptr %4, ptr %5, align 8
  %7 = call i32 @rand()
  %8 = srem i32 %7, 3
  switch i32 %8, label %14 [
    i32 0, label %9
    i32 1, label %11
  ]

9:                                                ; preds = %0
  %10 = load ptr, ptr %3, align 8
  store i32 11, ptr %10, align 4
  br label %18

11:                                               ; preds = %0
  %12 = load ptr, ptr %4, align 8
  %13 = load ptr, ptr %12, align 8
  store i32 12, ptr %13, align 4
  br label %18

14:                                               ; preds = %0
  %15 = load ptr, ptr %5, align 8
  %16 = load ptr, ptr %15, align 8
  %17 = load ptr, ptr %16, align 8
  store i32 13, ptr %17, align 4
  br label %18

18:                                               ; preds = %14, %11, %9
  store i32 0, ptr %6, align 4
  %19 = call i32 @rand()
  %20 = srem i32 %19, 3
  switch i32 %20, label %28 [
    i32 0, label %21
    i32 1, label %24
  ]

21:                                               ; preds = %18
  %22 = load ptr, ptr %3, align 8
  %23 = load i32, ptr %22, align 4
  store i32 %23, ptr %6, align 4
  br label %33

24:                                               ; preds = %18
  %25 = load ptr, ptr %4, align 8
  %26 = load ptr, ptr %25, align 8
  %27 = load i32, ptr %26, align 4
  store i32 %27, ptr %6, align 4
  br label %33

28:                                               ; preds = %18
  %29 = load ptr, ptr %5, align 8
  %30 = load ptr, ptr %29, align 8
  %31 = load ptr, ptr %30, align 8
  %32 = load i32, ptr %31, align 4
  store i32 %32, ptr %6, align 4
  br label %33

33:                                               ; preds = %28, %24, %21
  %34 = load i32, ptr %1, align 4
  ret i32 %34
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
