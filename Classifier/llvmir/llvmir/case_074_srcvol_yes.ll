; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_074_srcvol_yes/case_074_srcvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_074_srcvol_yes/case_074_srcvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

%struct.Accessor = type { i32, ptr }

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca [3 x %struct.Accessor], align 8
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = getelementptr inbounds [3 x %struct.Accessor], ptr %1, i64 0, i64 0
  %5 = getelementptr inbounds %struct.Accessor, ptr %4, i32 0, i32 0
  store i32 0, ptr %5, align 8
  %6 = getelementptr inbounds [3 x %struct.Accessor], ptr %1, i64 0, i64 0
  %7 = getelementptr inbounds %struct.Accessor, ptr %6, i32 0, i32 1
  store ptr @_ZL10load_plainPKi, ptr %7, align 8
  %8 = getelementptr inbounds [3 x %struct.Accessor], ptr %1, i64 0, i64 1
  %9 = getelementptr inbounds %struct.Accessor, ptr %8, i32 0, i32 0
  store i32 1, ptr %9, align 8
  %10 = getelementptr inbounds [3 x %struct.Accessor], ptr %1, i64 0, i64 1
  %11 = getelementptr inbounds %struct.Accessor, ptr %10, i32 0, i32 1
  store ptr @_ZL11load_doublePKi, ptr %11, align 8
  %12 = getelementptr inbounds [3 x %struct.Accessor], ptr %1, i64 0, i64 2
  %13 = getelementptr inbounds %struct.Accessor, ptr %12, i32 0, i32 0
  store i32 2, ptr %13, align 8
  %14 = getelementptr inbounds [3 x %struct.Accessor], ptr %1, i64 0, i64 2
  %15 = getelementptr inbounds %struct.Accessor, ptr %14, i32 0, i32 1
  store ptr @_ZL11load_offsetPKi, ptr %15, align 8
  store i32 0, ptr %2, align 4
  store i32 74, ptr %2, align 4
  %16 = load i32, ptr @_ZZ4mainE4tick, align 4
  %17 = srem i32 %16, 3
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds [3 x %struct.Accessor], ptr %1, i64 0, i64 %18
  %20 = getelementptr inbounds %struct.Accessor, ptr %19, i32 0, i32 1
  %21 = load ptr, ptr %20, align 8
  %22 = call noundef i32 %21(ptr noundef %2)
  store i32 %22, ptr %3, align 4
  %23 = load i32, ptr @_ZZ4mainE4tick, align 4
  %24 = add nsw i32 %23, 1
  store i32 %24, ptr @_ZZ4mainE4tick, align 4
  ret i32 0
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal noundef i32 @_ZL10load_plainPKi(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = load i32, ptr %3, align 4
  ret i32 %4
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal noundef i32 @_ZL11load_doublePKi(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = load i32, ptr %3, align 4
  %5 = mul nsw i32 %4, 2
  ret i32 %5
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal noundef i32 @_ZL11load_offsetPKi(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = load i32, ptr %3, align 4
  %5 = add nsw i32 %4, 7
  ret i32 %5
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
