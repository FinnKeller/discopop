; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_492_srcvol_yes/case_492_srcvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_492_srcvol_yes/case_492_srcvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse nounwind ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [16 x i8], align 1
  %3 = alloca ptr, align 8
  %4 = alloca i8, align 1
  store i32 0, ptr %1, align 4
  %5 = getelementptr inbounds [16 x i8], ptr %2, i64 0, i64 7
  store ptr %5, ptr %3, align 8
  %6 = load ptr, ptr %3, align 8
  store i8 43, ptr %6, align 1
  store i8 0, ptr %4, align 1
  %7 = load i32, ptr @_ZZ4mainE4tick, align 4
  %8 = srem i32 %7, 31
  switch i32 %8, label %21 [
    i32 17, label %9
    i32 18, label %15
  ]

9:                                                ; preds = %0
  %10 = getelementptr inbounds [16 x i8], ptr %2, i64 0, i64 7
  %11 = load i8, ptr %10, align 1
  %12 = sext i8 %11 to i32
  %13 = add nsw i32 %12, 1
  %14 = trunc i32 %13 to i8
  store i8 %14, ptr %4, align 1
  br label %27

15:                                               ; preds = %0
  %16 = getelementptr inbounds [16 x i8], ptr %2, i64 0, i64 7
  %17 = load i8, ptr %16, align 1
  %18 = sext i8 %17 to i32
  %19 = add nsw i32 %18, 2
  %20 = trunc i32 %19 to i8
  store i8 %20, ptr %4, align 1
  br label %27

21:                                               ; preds = %0
  %22 = getelementptr inbounds [16 x i8], ptr %2, i64 0, i64 7
  %23 = load i8, ptr %22, align 1
  %24 = sext i8 %23 to i32
  %25 = add nsw i32 %24, 3
  %26 = trunc i32 %25 to i8
  store i8 %26, ptr %4, align 1
  br label %27

27:                                               ; preds = %21, %15, %9
  %28 = load i32, ptr @_ZZ4mainE4tick, align 4
  %29 = add nsw i32 %28, 1
  store i32 %29, ptr @_ZZ4mainE4tick, align 4
  %30 = load i32, ptr %1, align 4
  ret i32 %30
}

attributes #0 = { mustprogress noinline norecurse nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 5]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Homebrew clang version 21.1.8"}
