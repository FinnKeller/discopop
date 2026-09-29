; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_049_sinkvol_yes/case_049_sinkvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_049_sinkvol_yes/case_049_sinkvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct.Handler = type { i32, ptr }

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca [3 x %struct.Handler], align 8
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = getelementptr inbounds [3 x %struct.Handler], ptr %1, i64 0, i64 0
  %5 = getelementptr inbounds nuw %struct.Handler, ptr %4, i32 0, i32 0
  store i32 0, ptr %5, align 8
  %6 = getelementptr inbounds [3 x %struct.Handler], ptr %1, i64 0, i64 0
  %7 = getelementptr inbounds nuw %struct.Handler, ptr %6, i32 0, i32 1
  store ptr @_ZL9store_lowPi, ptr %7, align 8
  %8 = getelementptr inbounds [3 x %struct.Handler], ptr %1, i64 0, i64 1
  %9 = getelementptr inbounds nuw %struct.Handler, ptr %8, i32 0, i32 0
  store i32 1, ptr %9, align 8
  %10 = getelementptr inbounds [3 x %struct.Handler], ptr %1, i64 0, i64 1
  %11 = getelementptr inbounds nuw %struct.Handler, ptr %10, i32 0, i32 1
  store ptr @_ZL9store_midPi, ptr %11, align 8
  %12 = getelementptr inbounds [3 x %struct.Handler], ptr %1, i64 0, i64 2
  %13 = getelementptr inbounds nuw %struct.Handler, ptr %12, i32 0, i32 0
  store i32 2, ptr %13, align 8
  %14 = getelementptr inbounds [3 x %struct.Handler], ptr %1, i64 0, i64 2
  %15 = getelementptr inbounds nuw %struct.Handler, ptr %14, i32 0, i32 1
  store ptr @_ZL10store_highPi, ptr %15, align 8
  store i32 0, ptr %2, align 4
  %16 = load i32, ptr @_ZZ4mainE4tick, align 4
  %17 = srem i32 %16, 3
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds [3 x %struct.Handler], ptr %1, i64 0, i64 %18
  %20 = getelementptr inbounds nuw %struct.Handler, ptr %19, i32 0, i32 1
  %21 = load ptr, ptr %20, align 8
  call void %21(ptr noundef %2)
  %22 = load i32, ptr %2, align 4
  store i32 %22, ptr %3, align 4
  %23 = load i32, ptr @_ZZ4mainE4tick, align 4
  %24 = add nsw i32 %23, 1
  store i32 %24, ptr @_ZZ4mainE4tick, align 4
  ret i32 0
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @_ZL9store_lowPi(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  store i32 5, ptr %3, align 4
  ret void
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @_ZL9store_midPi(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  store i32 6, ptr %3, align 4
  ret void
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @_ZL10store_highPi(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  store i32 7, ptr %3, align 4
  ret void
}

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { mustprogress noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 5]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Homebrew clang version 21.1.8"}
