; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_531_bothvol_yes/case_531_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_531_bothvol_yes/case_531_bothvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4
@_ZL6g_cell = internal global i16 0, align 2

; Function Attrs: mustprogress noinline norecurse nounwind ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i16, align 2
  store i32 0, ptr %1, align 4
  store i16 0, ptr @_ZL6g_cell, align 2
  %3 = load i32, ptr @_ZZ4mainE4tick, align 4
  %4 = srem i32 %3, 41
  %5 = icmp eq i32 %4, 23
  br i1 %5, label %6, label %7

6:                                                ; preds = %0
  store i16 38, ptr @_ZL6g_cell, align 2
  br label %8

7:                                                ; preds = %0
  store i16 31, ptr @_ZL6g_cell, align 2
  br label %8

8:                                                ; preds = %7, %6
  %9 = load i16, ptr @_ZL6g_cell, align 2
  store i16 %9, ptr %2, align 2
  %10 = load i32, ptr @_ZZ4mainE4tick, align 4
  %11 = srem i32 %10, 29
  %12 = icmp eq i32 %11, 19
  br i1 %12, label %13, label %20

13:                                               ; preds = %8
  %14 = load i16, ptr @_ZL6g_cell, align 2
  %15 = sext i16 %14 to i32
  %16 = load i16, ptr %2, align 2
  %17 = sext i16 %16 to i32
  %18 = add nsw i32 %17, %15
  %19 = trunc i32 %18 to i16
  store i16 %19, ptr %2, align 2
  br label %20

20:                                               ; preds = %13, %8
  %21 = load i32, ptr @_ZZ4mainE4tick, align 4
  %22 = add nsw i32 %21, 1
  store i32 %22, ptr @_ZZ4mainE4tick, align 4
  %23 = load i32, ptr %1, align 4
  ret i32 %23
}

attributes #0 = { mustprogress noinline norecurse nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 16.0.6"}
