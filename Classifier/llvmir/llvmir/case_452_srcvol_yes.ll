; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_452_srcvol_yes/case_452_srcvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_452_srcvol_yes/case_452_srcvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse nounwind ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [16 x i16], align 2
  %3 = alloca ptr, align 8
  %4 = alloca i16, align 2
  store i32 0, ptr %1, align 4
  %5 = getelementptr inbounds [16 x i16], ptr %2, i64 0, i64 7
  store ptr %5, ptr %3, align 8
  %6 = load ptr, ptr %3, align 8
  store i16 40, ptr %6, align 2
  %7 = getelementptr inbounds [16 x i16], ptr %2, i64 0, i64 7
  %8 = load i16, ptr %7, align 2
  store i16 %8, ptr %4, align 2
  %9 = load i32, ptr @_ZZ4mainE4tick, align 4
  %10 = srem i32 %9, 23
  %11 = icmp eq i32 %10, 4
  br i1 %11, label %12, label %20

12:                                               ; preds = %0
  %13 = getelementptr inbounds [16 x i16], ptr %2, i64 0, i64 7
  %14 = load i16, ptr %13, align 2
  %15 = sext i16 %14 to i32
  %16 = load i16, ptr %4, align 2
  %17 = sext i16 %16 to i32
  %18 = add nsw i32 %17, %15
  %19 = trunc i32 %18 to i16
  store i16 %19, ptr %4, align 2
  br label %20

20:                                               ; preds = %12, %0
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
