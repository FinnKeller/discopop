; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_077_bothvol_yes/case_077_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_077_bothvol_yes/case_077_bothvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse nounwind ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %2, align 4
  %4 = load i32, ptr @_ZZ4mainE4tick, align 4
  %5 = srem i32 %4, 41
  %6 = icmp eq i32 %5, 7
  br i1 %6, label %7, label %8

7:                                                ; preds = %0
  store i32 100, ptr %2, align 4
  br label %9

8:                                                ; preds = %0
  store i32 200, ptr %2, align 4
  br label %9

9:                                                ; preds = %8, %7
  store i32 0, ptr %3, align 4
  %10 = load i32, ptr @_ZZ4mainE4tick, align 4
  %11 = srem i32 %10, 37
  %12 = icmp eq i32 %11, 11
  br i1 %12, label %13, label %16

13:                                               ; preds = %9
  %14 = load i32, ptr %2, align 4
  %15 = mul nsw i32 %14, 2
  store i32 %15, ptr %3, align 4
  br label %19

16:                                               ; preds = %9
  %17 = load i32, ptr %2, align 4
  %18 = add nsw i32 %17, 1
  store i32 %18, ptr %3, align 4
  br label %19

19:                                               ; preds = %16, %13
  %20 = load i32, ptr @_ZZ4mainE4tick, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr @_ZZ4mainE4tick, align 4
  %22 = load i32, ptr %1, align 4
  ret i32 %22
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
