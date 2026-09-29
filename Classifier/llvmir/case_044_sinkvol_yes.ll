; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_044_sinkvol_yes/case_044_sinkvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_044_sinkvol_yes/case_044_sinkvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct.Fields = type { i32, i32 }

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse nounwind ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.Fields, align 4
  %3 = alloca i64, align 8
  %4 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %5 = getelementptr inbounds nuw %struct.Fields, ptr %2, i32 0, i32 0
  store i32 0, ptr %5, align 4
  %6 = getelementptr inbounds nuw %struct.Fields, ptr %2, i32 0, i32 1
  store i32 0, ptr %6, align 4
  store i64 -1, ptr %3, align 8
  %7 = load i32, ptr @_ZZ4mainE4tick, align 4
  %8 = srem i32 %7, 23
  %9 = icmp eq i32 %8, 5
  br i1 %9, label %10, label %12

10:                                               ; preds = %0
  %11 = getelementptr inbounds nuw %struct.Fields, ptr %2, i32 0, i32 1
  store i32 71, ptr %11, align 4
  store i64 4, ptr %3, align 8
  br label %14

12:                                               ; preds = %0
  %13 = getelementptr inbounds nuw %struct.Fields, ptr %2, i32 0, i32 0
  store i32 72, ptr %13, align 4
  store i64 0, ptr %3, align 8
  br label %14

14:                                               ; preds = %12, %10
  %15 = load i64, ptr %3, align 8
  %16 = getelementptr inbounds i8, ptr %2, i64 %15
  %17 = load i32, ptr %16, align 4
  store i32 %17, ptr %4, align 4
  %18 = load i32, ptr @_ZZ4mainE4tick, align 4
  %19 = add nsw i32 %18, 1
  store i32 %19, ptr @_ZZ4mainE4tick, align 4
  %20 = load i32, ptr %1, align 4
  ret i32 %20
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
