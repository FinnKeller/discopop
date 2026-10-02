; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_561_bothvol_yes/case_561_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_561_bothvol_yes/case_561_bothvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse nounwind ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [16 x i32], align 4
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %9 = getelementptr inbounds [16 x i32], ptr %2, i64 0, i64 0
  %10 = getelementptr inbounds i32, ptr %9, i64 5
  store ptr %10, ptr %3, align 8
  %11 = load ptr, ptr %3, align 8
  store ptr %11, ptr %4, align 8
  %12 = load ptr, ptr %3, align 8
  store ptr %12, ptr %5, align 8
  %13 = load i32, ptr @_ZZ4mainE4tick, align 4
  %14 = srem i32 %13, 19
  %15 = icmp eq i32 %14, 5
  br i1 %15, label %16, label %18

16:                                               ; preds = %0
  %17 = load ptr, ptr %5, align 8
  store i32 27, ptr %17, align 4
  br label %20

18:                                               ; preds = %0
  %19 = load ptr, ptr %4, align 8
  store i32 20, ptr %19, align 4
  br label %20

20:                                               ; preds = %18, %16
  %21 = load ptr, ptr %3, align 8
  store ptr %21, ptr %6, align 8
  %22 = load ptr, ptr %3, align 8
  store ptr %22, ptr %7, align 8
  store i32 0, ptr %8, align 4
  %23 = load i32, ptr @_ZZ4mainE4tick, align 4
  %24 = srem i32 %23, 23
  %25 = icmp eq i32 %24, 11
  br i1 %25, label %26, label %29

26:                                               ; preds = %20
  %27 = load ptr, ptr %7, align 8
  %28 = load i32, ptr %27, align 4
  store i32 %28, ptr %8, align 4
  br label %32

29:                                               ; preds = %20
  %30 = load ptr, ptr %6, align 8
  %31 = load i32, ptr %30, align 4
  store i32 %31, ptr %8, align 4
  br label %32

32:                                               ; preds = %29, %26
  %33 = load i32, ptr @_ZZ4mainE4tick, align 4
  %34 = add nsw i32 %33, 1
  store i32 %34, ptr @_ZZ4mainE4tick, align 4
  %35 = load i32, ptr %1, align 4
  ret i32 %35
}

attributes #0 = { mustprogress noinline norecurse nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 16.0.6"}
