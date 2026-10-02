; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_478_srcvol_yes/case_478_srcvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_478_srcvol_yes/case_478_srcvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [16 x i64], align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i64, align 8
  store i32 0, ptr %1, align 4
  store ptr @_ZL11store_valuePx, ptr %3, align 8
  %7 = load ptr, ptr %3, align 8
  %8 = getelementptr inbounds [16 x i64], ptr %2, i64 0, i64 7
  call void %7(ptr noundef %8)
  %9 = getelementptr inbounds [16 x i64], ptr %2, i64 0, i64 7
  store ptr %9, ptr %4, align 8
  %10 = getelementptr inbounds [16 x i64], ptr %2, i64 0, i64 7
  store ptr %10, ptr %5, align 8
  store i64 0, ptr %6, align 8
  %11 = load i32, ptr @_ZZ4mainE4tick, align 4
  %12 = srem i32 %11, 31
  %13 = icmp eq i32 %12, 7
  br i1 %13, label %14, label %17

14:                                               ; preds = %0
  %15 = load ptr, ptr %5, align 8
  %16 = load i64, ptr %15, align 8
  store i64 %16, ptr %6, align 8
  br label %20

17:                                               ; preds = %0
  %18 = load ptr, ptr %4, align 8
  %19 = load i64, ptr %18, align 8
  store i64 %19, ptr %6, align 8
  br label %20

20:                                               ; preds = %17, %14
  %21 = load i32, ptr @_ZZ4mainE4tick, align 4
  %22 = add nsw i32 %21, 1
  store i32 %22, ptr @_ZZ4mainE4tick, align 4
  %23 = load i32, ptr %1, align 4
  ret i32 %23
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @_ZL11store_valuePx(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  store i64 54, ptr %3, align 8
  ret void
}

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #1 = { mustprogress noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 16.0.6"}
