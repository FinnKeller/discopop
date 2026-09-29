; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_510_srcvol_yes/case_510_srcvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_510_srcvol_yes/case_510_srcvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4
@__const.main.sink_table = private unnamed_addr constant [4 x ptr] [ptr @_ZL11store_valuePx, ptr @_ZL11store_valuePx, ptr @_ZL11store_valuePx, ptr @_ZL11store_valuePx], align 8
@_ZL8pad_area = internal global [64 x i32] zeroinitializer, align 4

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca [4 x ptr], align 8
  %5 = alloca i64, align 8
  store i32 0, ptr %1, align 4
  %6 = call noalias noundef nonnull ptr @_Znwm(i64 noundef 8) #5
  store i64 0, ptr %6, align 8
  store ptr %6, ptr %2, align 8
  %7 = call noundef i32 @_ZL9pad_readsi(i32 noundef 40)
  store i32 %7, ptr %3, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %4, ptr align 8 @__const.main.sink_table, i64 32, i1 false)
  %8 = call i32 @rand()
  %9 = srem i32 %8, 4
  %10 = sext i32 %9 to i64
  %11 = getelementptr inbounds [4 x ptr], ptr %4, i64 0, i64 %10
  %12 = load ptr, ptr %11, align 8
  %13 = load ptr, ptr %2, align 8
  call void %12(ptr noundef %13)
  store i64 0, ptr %5, align 8
  %14 = load i32, ptr @_ZZ4mainE4tick, align 4
  %15 = srem i32 %14, 29
  switch i32 %15, label %24 [
    i32 9, label %16
    i32 10, label %20
  ]

16:                                               ; preds = %0
  %17 = load ptr, ptr %2, align 8
  %18 = load i64, ptr %17, align 8
  %19 = add nsw i64 %18, 1
  store i64 %19, ptr %5, align 8
  br label %28

20:                                               ; preds = %0
  %21 = load ptr, ptr %2, align 8
  %22 = load i64, ptr %21, align 8
  %23 = add nsw i64 %22, 2
  store i64 %23, ptr %5, align 8
  br label %28

24:                                               ; preds = %0
  %25 = load ptr, ptr %2, align 8
  %26 = load i64, ptr %25, align 8
  %27 = add nsw i64 %26, 3
  store i64 %27, ptr %5, align 8
  br label %28

28:                                               ; preds = %24, %20, %16
  %29 = load i32, ptr @_ZZ4mainE4tick, align 4
  %30 = add nsw i32 %29, 1
  store i32 %30, ptr @_ZZ4mainE4tick, align 4
  %31 = load i32, ptr %1, align 4
  ret i32 %31
}

; Function Attrs: nobuiltin allocsize(0)
declare noundef nonnull ptr @_Znwm(i64 noundef) #1

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal noundef i32 @_ZL9pad_readsi(i32 noundef %0) #2 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  store i32 0, ptr %3, align 4
  store i32 0, ptr %4, align 4
  br label %6

6:                                                ; preds = %25, %1
  %7 = load i32, ptr %4, align 4
  %8 = load i32, ptr %2, align 4
  %9 = icmp slt i32 %7, %8
  br i1 %9, label %10, label %28

10:                                               ; preds = %6
  store i32 0, ptr %5, align 4
  br label %11

11:                                               ; preds = %21, %10
  %12 = load i32, ptr %5, align 4
  %13 = icmp slt i32 %12, 64
  br i1 %13, label %14, label %24

14:                                               ; preds = %11
  %15 = load i32, ptr %5, align 4
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds [64 x i32], ptr @_ZL8pad_area, i64 0, i64 %16
  %18 = load i32, ptr %17, align 4
  %19 = load i32, ptr %3, align 4
  %20 = add nsw i32 %19, %18
  store i32 %20, ptr %3, align 4
  br label %21

21:                                               ; preds = %14
  %22 = load i32, ptr %5, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, ptr %5, align 4
  br label %11, !llvm.loop !6

24:                                               ; preds = %11
  br label %25

25:                                               ; preds = %24
  %26 = load i32, ptr %4, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, ptr %4, align 4
  br label %6, !llvm.loop !8

28:                                               ; preds = %6
  %29 = load i32, ptr %3, align 4
  ret i32 %29
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @_ZL11store_valuePx(ptr noundef %0) #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  store i64 72, ptr %3, align 8
  ret void
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias writeonly captures(none), ptr noalias readonly captures(none), i64, i1 immarg) #3

declare i32 @rand() #4

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { nobuiltin allocsize(0) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { mustprogress noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #4 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #5 = { builtin allocsize(0) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 5]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Homebrew clang version 21.1.8"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
