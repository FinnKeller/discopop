; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_095_bothvol_yes/case_095_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_095_bothvol_yes/case_095_bothvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

%struct.Bundle = type { i32, i32 }

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse nounwind ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.Bundle, align 4
  %3 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %4 = getelementptr inbounds %struct.Bundle, ptr %2, i32 0, i32 0
  store i32 0, ptr %4, align 4
  %5 = getelementptr inbounds %struct.Bundle, ptr %2, i32 0, i32 1
  store i32 0, ptr %5, align 4
  store i32 0, ptr %3, align 4
  %6 = load i32, ptr @_ZZ4mainE4tick, align 4
  %7 = srem i32 %6, 33
  %8 = icmp eq i32 %7, 7
  br i1 %8, label %9, label %14

9:                                                ; preds = %0
  %10 = getelementptr inbounds %struct.Bundle, ptr %2, i32 0, i32 1
  store i32 81, ptr %10, align 4
  %11 = getelementptr inbounds %struct.Bundle, ptr %2, i32 0, i32 1
  %12 = load i32, ptr %11, align 4
  %13 = add nsw i32 %12, 1
  store i32 %13, ptr %3, align 4
  br label %19

14:                                               ; preds = %0
  %15 = getelementptr inbounds %struct.Bundle, ptr %2, i32 0, i32 0
  store i32 82, ptr %15, align 4
  %16 = getelementptr inbounds %struct.Bundle, ptr %2, i32 0, i32 0
  %17 = load i32, ptr %16, align 4
  %18 = add nsw i32 %17, 2
  store i32 %18, ptr %3, align 4
  br label %19

19:                                               ; preds = %14, %9
  %20 = load i32, ptr @_ZZ4mainE4tick, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr @_ZZ4mainE4tick, align 4
  %22 = load i32, ptr %1, align 4
  ret i32 %22
}

attributes #0 = { mustprogress noinline norecurse nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 16.0.6"}
