; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_064_srcvol_yes/case_064_srcvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_064_srcvol_yes/case_064_srcvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define noundef i32 @_Z10reader_onePKi(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = load i32, ptr %3, align 4
  %5 = add nsw i32 %4, 1
  ret i32 %5
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define noundef i32 @_Z10reader_twoPKi(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = load i32, ptr %3, align 4
  %5 = add nsw i32 %4, 2
  ret i32 %5
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define noundef i32 @_Z12reader_threePKi(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = load i32, ptr %3, align 4
  %5 = add nsw i32 %4, 3
  ret i32 %5
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define noundef i32 @_Z13dispatch_readPKii(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  %6 = load i32, ptr %5, align 4
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %11

8:                                                ; preds = %2
  %9 = load ptr, ptr %4, align 8
  %10 = call noundef i32 @_Z10reader_onePKi(ptr noundef %9)
  store i32 %10, ptr %3, align 4
  br label %20

11:                                               ; preds = %2
  %12 = load i32, ptr %5, align 4
  %13 = icmp eq i32 %12, 1
  br i1 %13, label %14, label %17

14:                                               ; preds = %11
  %15 = load ptr, ptr %4, align 8
  %16 = call noundef i32 @_Z10reader_twoPKi(ptr noundef %15)
  store i32 %16, ptr %3, align 4
  br label %20

17:                                               ; preds = %11
  %18 = load ptr, ptr %4, align 8
  %19 = call noundef i32 @_Z12reader_threePKi(ptr noundef %18)
  store i32 %19, ptr %3, align 4
  br label %20

20:                                               ; preds = %17, %14, %8
  %21 = load i32, ptr %3, align 4
  ret i32 %21
}

; Function Attrs: mustprogress noinline norecurse nounwind ssp uwtable(sync)
define noundef i32 @main() #1 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 64, ptr %1, align 4
  %3 = load i32, ptr @_ZZ4mainE4tick, align 4
  %4 = srem i32 %3, 3
  %5 = call noundef i32 @_Z13dispatch_readPKii(ptr noundef %1, i32 noundef %4)
  store i32 %5, ptr %2, align 4
  %6 = load i32, ptr @_ZZ4mainE4tick, align 4
  %7 = add nsw i32 %6, 1
  store i32 %7, ptr @_ZZ4mainE4tick, align 4
  ret i32 0
}

attributes #0 = { mustprogress noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { mustprogress noinline norecurse nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 5]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Homebrew clang version 21.1.8"}
