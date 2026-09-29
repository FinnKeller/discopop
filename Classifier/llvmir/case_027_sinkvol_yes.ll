; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_027_sinkvol_yes/case_027_sinkvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_027_sinkvol_yes/case_027_sinkvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse nounwind ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %2, align 4
  store i32 0, ptr %3, align 4
  store ptr %2, ptr %4, align 8
  %6 = load i32, ptr @_ZZ4mainE4tick, align 4
  %7 = srem i32 %6, 41
  %8 = icmp eq i32 %7, 7
  br i1 %8, label %9, label %10

9:                                                ; preds = %0
  store i32 100, ptr %3, align 4
  store ptr %3, ptr %4, align 8
  br label %11

10:                                               ; preds = %0
  store i32 200, ptr %2, align 4
  br label %11

11:                                               ; preds = %10, %9
  %12 = load ptr, ptr %4, align 8
  %13 = load i32, ptr %12, align 4
  store i32 %13, ptr %5, align 4
  %14 = load i32, ptr @_ZZ4mainE4tick, align 4
  %15 = add nsw i32 %14, 1
  store i32 %15, ptr @_ZZ4mainE4tick, align 4
  %16 = load i32, ptr %1, align 4
  ret i32 %16
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
