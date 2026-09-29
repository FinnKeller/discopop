; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_476_srcvol_yes/case_476_srcvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_476_srcvol_yes/case_476_srcvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [16 x i64], align 8
  %3 = alloca i32, align 4
  %4 = alloca i64, align 8
  store i32 0, ptr %1, align 4
  %5 = call i32 @rand()
  %6 = srem i32 %5, 16
  store i32 %6, ptr %3, align 4
  %7 = load i32, ptr %3, align 4
  %8 = sext i32 %7 to i64
  %9 = getelementptr inbounds [16 x i64], ptr %2, i64 0, i64 %8
  store i64 66, ptr %9, align 8
  store i64 0, ptr %4, align 8
  %10 = load i32, ptr @_ZZ4mainE4tick, align 4
  %11 = srem i32 %10, 37
  switch i32 %11, label %24 [
    i32 11, label %12
    i32 12, label %18
  ]

12:                                               ; preds = %0
  %13 = load i32, ptr %3, align 4
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds [16 x i64], ptr %2, i64 0, i64 %14
  %16 = load i64, ptr %15, align 8
  %17 = add nsw i64 %16, 1
  store i64 %17, ptr %4, align 8
  br label %30

18:                                               ; preds = %0
  %19 = load i32, ptr %3, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds [16 x i64], ptr %2, i64 0, i64 %20
  %22 = load i64, ptr %21, align 8
  %23 = add nsw i64 %22, 2
  store i64 %23, ptr %4, align 8
  br label %30

24:                                               ; preds = %0
  %25 = load i32, ptr %3, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds [16 x i64], ptr %2, i64 0, i64 %26
  %28 = load i64, ptr %27, align 8
  %29 = add nsw i64 %28, 3
  store i64 %29, ptr %4, align 8
  br label %30

30:                                               ; preds = %24, %18, %12
  %31 = load i32, ptr @_ZZ4mainE4tick, align 4
  %32 = add nsw i32 %31, 1
  store i32 %32, ptr @_ZZ4mainE4tick, align 4
  %33 = load i32, ptr %1, align 4
  ret i32 %33
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
