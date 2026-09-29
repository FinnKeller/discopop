; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_545_bothvol_yes/case_545_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_545_bothvol_yes/case_545_bothvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %5 = call noalias noundef nonnull ptr @_Znwm(i64 noundef 4) #3
  store i32 0, ptr %5, align 4
  store ptr %5, ptr %2, align 8
  store ptr @_ZL12store_commonPj, ptr %3, align 8
  %6 = load i32, ptr @_ZZ4mainE4tick, align 4
  %7 = srem i32 %6, 19
  %8 = icmp eq i32 %7, 5
  br i1 %8, label %9, label %10

9:                                                ; preds = %0
  store ptr @_ZL10store_rarePj, ptr %3, align 8
  br label %10

10:                                               ; preds = %9, %0
  %11 = load ptr, ptr %3, align 8
  %12 = load ptr, ptr %2, align 8
  call void %11(ptr noundef %12)
  store i32 0, ptr %4, align 4
  %13 = load i32, ptr @_ZZ4mainE4tick, align 4
  %14 = srem i32 %13, 29
  switch i32 %14, label %23 [
    i32 9, label %15
    i32 10, label %19
  ]

15:                                               ; preds = %10
  %16 = load ptr, ptr %2, align 8
  %17 = load i32, ptr %16, align 4
  %18 = add i32 %17, 1
  store i32 %18, ptr %4, align 4
  br label %27

19:                                               ; preds = %10
  %20 = load ptr, ptr %2, align 8
  %21 = load i32, ptr %20, align 4
  %22 = add i32 %21, 2
  store i32 %22, ptr %4, align 4
  br label %27

23:                                               ; preds = %10
  %24 = load ptr, ptr %2, align 8
  %25 = load i32, ptr %24, align 4
  %26 = add i32 %25, 3
  store i32 %26, ptr %4, align 4
  br label %27

27:                                               ; preds = %23, %19, %15
  %28 = load i32, ptr @_ZZ4mainE4tick, align 4
  %29 = add nsw i32 %28, 1
  store i32 %29, ptr @_ZZ4mainE4tick, align 4
  %30 = load i32, ptr %1, align 4
  ret i32 %30
}

; Function Attrs: nobuiltin allocsize(0)
declare noundef nonnull ptr @_Znwm(i64 noundef) #1

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @_ZL12store_commonPj(ptr noundef %0) #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  store i32 59, ptr %3, align 4
  ret void
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @_ZL10store_rarePj(ptr noundef %0) #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  store i32 66, ptr %3, align 4
  ret void
}

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { nobuiltin allocsize(0) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { mustprogress noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { builtin allocsize(0) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 5]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Homebrew clang version 21.1.8"}
