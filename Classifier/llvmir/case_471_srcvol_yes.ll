; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_471_srcvol_yes/case_471_srcvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_471_srcvol_yes/case_471_srcvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4
@_ZZ4mainE4cell = internal global i16 0, align 2

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i16, align 2
  store i32 0, ptr %1, align 4
  store i16 0, ptr @_ZZ4mainE4cell, align 2
  call void @_ZL13store_genericIsEvPT_S0_(ptr noundef @_ZZ4mainE4cell, i16 noundef signext 54)
  store i16 0, ptr %2, align 2
  %3 = load i32, ptr @_ZZ4mainE4tick, align 4
  %4 = srem i32 %3, 23
  %5 = icmp eq i32 %4, 11
  br i1 %5, label %6, label %11

6:                                                ; preds = %0
  %7 = load i16, ptr @_ZZ4mainE4cell, align 2
  %8 = sext i16 %7 to i32
  %9 = add nsw i32 %8, 1
  %10 = trunc i32 %9 to i16
  store i16 %10, ptr %2, align 2
  br label %16

11:                                               ; preds = %0
  %12 = load i16, ptr @_ZZ4mainE4cell, align 2
  %13 = sext i16 %12 to i32
  %14 = add nsw i32 %13, 2
  %15 = trunc i32 %14 to i16
  store i16 %15, ptr %2, align 2
  br label %16

16:                                               ; preds = %11, %6
  %17 = load i32, ptr @_ZZ4mainE4tick, align 4
  %18 = add nsw i32 %17, 1
  store i32 %18, ptr @_ZZ4mainE4tick, align 4
  %19 = load i32, ptr %1, align 4
  ret i32 %19
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @_ZL13store_genericIsEvPT_S0_(ptr noundef %0, i16 noundef signext %1) #1 {
  %3 = alloca ptr, align 8
  %4 = alloca i16, align 2
  store ptr %0, ptr %3, align 8
  store i16 %1, ptr %4, align 2
  %5 = load i16, ptr %4, align 2
  %6 = load ptr, ptr %3, align 8
  store i16 %5, ptr %6, align 2
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
