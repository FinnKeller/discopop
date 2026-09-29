; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_525_srcvol_yes/case_525_srcvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_525_srcvol_yes/case_525_srcvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4
@__const.main.sink_table = private unnamed_addr constant [4 x ptr] [ptr @_ZL11store_valuePc, ptr @_ZL11store_valuePc, ptr @_ZL11store_valuePc, ptr @_ZL11store_valuePc], align 8
@__const.main.src_table = private unnamed_addr constant [2 x ptr] [ptr @_ZL11load_commonPKc, ptr @_ZL9load_rarePKc], align 8
@_ZL8pad_area = internal global [32 x i32] zeroinitializer, align 4

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca [16 x i8], align 1
  %2 = alloca ptr, align 8
  %3 = alloca [4 x ptr], align 8
  %4 = alloca [2 x ptr], align 8
  %5 = alloca i32, align 4
  %6 = alloca i8, align 1
  %7 = getelementptr inbounds [16 x i8], ptr %1, i64 0, i64 0
  %8 = getelementptr inbounds i8, ptr %7, i64 5
  store ptr %8, ptr %2, align 8
  call void @_ZL10pad_writesi(i32 noundef 8)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %3, ptr align 8 @__const.main.sink_table, i64 32, i1 false)
  %9 = call i32 @rand()
  %10 = srem i32 %9, 4
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds [4 x ptr], ptr %3, i64 0, i64 %11
  %13 = load ptr, ptr %12, align 8
  %14 = load ptr, ptr %2, align 8
  call void %13(ptr noundef %14)
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %4, ptr align 8 @__const.main.src_table, i64 16, i1 false)
  %15 = load i32, ptr @_ZZ4mainE4tick, align 4
  %16 = srem i32 %15, 31
  %17 = icmp eq i32 %16, 7
  %18 = zext i1 %17 to i64
  %19 = select i1 %17, i32 1, i32 0
  store i32 %19, ptr %5, align 4
  %20 = load i32, ptr %5, align 4
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds [2 x ptr], ptr %4, i64 0, i64 %21
  %23 = load ptr, ptr %22, align 8
  %24 = load ptr, ptr %2, align 8
  %25 = call noundef signext i8 %23(ptr noundef %24)
  store i8 %25, ptr %6, align 1
  %26 = load i32, ptr @_ZZ4mainE4tick, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, ptr @_ZZ4mainE4tick, align 4
  ret i32 0
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @_ZL10pad_writesi(i32 noundef %0) #1 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  store i32 0, ptr %3, align 4
  br label %5

5:                                                ; preds = %24, %1
  %6 = load i32, ptr %3, align 4
  %7 = load i32, ptr %2, align 4
  %8 = icmp slt i32 %6, %7
  br i1 %8, label %9, label %27

9:                                                ; preds = %5
  store i32 0, ptr %4, align 4
  br label %10

10:                                               ; preds = %20, %9
  %11 = load i32, ptr %4, align 4
  %12 = icmp slt i32 %11, 32
  br i1 %12, label %13, label %23

13:                                               ; preds = %10
  %14 = load i32, ptr %3, align 4
  %15 = load i32, ptr %4, align 4
  %16 = xor i32 %14, %15
  %17 = load i32, ptr %4, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds [32 x i32], ptr @_ZL8pad_area, i64 0, i64 %18
  store i32 %16, ptr %19, align 4
  br label %20

20:                                               ; preds = %13
  %21 = load i32, ptr %4, align 4
  %22 = add nsw i32 %21, 1
  store i32 %22, ptr %4, align 4
  br label %10, !llvm.loop !6

23:                                               ; preds = %10
  br label %24

24:                                               ; preds = %23
  %25 = load i32, ptr %3, align 4
  %26 = add nsw i32 %25, 1
  store i32 %26, ptr %3, align 4
  br label %5, !llvm.loop !8

27:                                               ; preds = %5
  ret void
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @_ZL11store_valuePc(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  store i8 63, ptr %3, align 1
  ret void
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias writeonly captures(none), ptr noalias readonly captures(none), i64, i1 immarg) #2

declare i32 @rand() #3

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal noundef signext i8 @_ZL11load_commonPKc(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = load i8, ptr %3, align 1
  %5 = sext i8 %4 to i32
  %6 = add nsw i32 %5, 1
  %7 = trunc i32 %6 to i8
  ret i8 %7
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal noundef signext i8 @_ZL9load_rarePKc(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = load i8, ptr %3, align 1
  %5 = sext i8 %4 to i32
  %6 = add nsw i32 %5, 2
  %7 = trunc i32 %6 to i8
  ret i8 %7
}

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { mustprogress noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }

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
