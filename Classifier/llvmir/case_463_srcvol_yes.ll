; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_463_srcvol_yes/case_463_srcvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_463_srcvol_yes/case_463_srcvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4
@_ZL6g_cell = internal global i64 0, align 8

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i64, align 8
  store i32 0, ptr %1, align 4
  store i64 0, ptr @_ZL6g_cell, align 8
  store ptr @_ZL6g_cell, ptr %2, align 8
  store ptr @_ZL6g_cell, ptr %3, align 8
  %7 = call i32 @rand()
  %8 = srem i32 %7, 2
  %9 = icmp eq i32 %8, 0
  br i1 %9, label %10, label %12

10:                                               ; preds = %0
  %11 = load ptr, ptr %2, align 8
  br label %14

12:                                               ; preds = %0
  %13 = load ptr, ptr %3, align 8
  br label %14

14:                                               ; preds = %12, %10
  %15 = phi ptr [ %11, %10 ], [ %13, %12 ]
  store ptr %15, ptr %4, align 8
  %16 = load ptr, ptr %4, align 8
  store i64 64, ptr %16, align 8
  store ptr @_ZL11load_commonPKx, ptr %5, align 8
  %17 = load i32, ptr @_ZZ4mainE4tick, align 4
  %18 = srem i32 %17, 29
  %19 = icmp eq i32 %18, 19
  br i1 %19, label %20, label %21

20:                                               ; preds = %14
  store ptr @_ZL9load_rarePKx, ptr %5, align 8
  br label %21

21:                                               ; preds = %20, %14
  %22 = load ptr, ptr %5, align 8
  %23 = call noundef i64 %22(ptr noundef @_ZL6g_cell)
  store i64 %23, ptr %6, align 8
  %24 = load i32, ptr @_ZZ4mainE4tick, align 4
  %25 = add nsw i32 %24, 1
  store i32 %25, ptr @_ZZ4mainE4tick, align 4
  %26 = load i32, ptr %1, align 4
  ret i32 %26
}

declare i32 @rand() #1

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal noundef i64 @_ZL11load_commonPKx(ptr noundef %0) #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = load i64, ptr %3, align 8
  %5 = add nsw i64 %4, 1
  ret i64 %5
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal noundef i64 @_ZL9load_rarePKx(ptr noundef %0) #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = load i64, ptr %3, align 8
  %5 = add nsw i64 %4, 2
  ret i64 %5
}

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { mustprogress noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 5]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Homebrew clang version 21.1.8"}
