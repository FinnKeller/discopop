; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_544_bothvol_yes/case_544_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_544_bothvol_yes/case_544_bothvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

@_ZZ4mainE4tick = internal global i32 0, align 4
@_ZZ4mainE4cell = internal global i8 0, align 1
@__const.main.src_table = private unnamed_addr constant [2 x ptr] [ptr @_ZL11load_commonPKc, ptr @_ZL9load_rarePKc], align 8

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [2 x ptr], align 8
  %3 = alloca i32, align 4
  %4 = alloca i8, align 1
  store i32 0, ptr %1, align 4
  store i8 0, ptr @_ZZ4mainE4cell, align 1
  %5 = load i32, ptr @_ZZ4mainE4tick, align 4
  %6 = srem i32 %5, 31
  %7 = icmp eq i32 %6, 7
  br i1 %7, label %8, label %9

8:                                                ; preds = %0
  call void @_ZL10store_rarePc(ptr noundef @_ZZ4mainE4cell)
  br label %10

9:                                                ; preds = %0
  call void @_ZL12store_commonPc(ptr noundef @_ZZ4mainE4cell)
  br label %10

10:                                               ; preds = %9, %8
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %2, ptr align 8 @__const.main.src_table, i64 16, i1 false)
  %11 = load i32, ptr @_ZZ4mainE4tick, align 4
  %12 = srem i32 %11, 29
  %13 = icmp eq i32 %12, 9
  %14 = zext i1 %13 to i64
  %15 = select i1 %13, i32 1, i32 0
  store i32 %15, ptr %3, align 4
  %16 = load i32, ptr %3, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [2 x ptr], ptr %2, i64 0, i64 %17
  %19 = load ptr, ptr %18, align 8
  %20 = call noundef signext i8 %19(ptr noundef @_ZZ4mainE4cell)
  store i8 %20, ptr %4, align 1
  %21 = load i32, ptr @_ZZ4mainE4tick, align 4
  %22 = add nsw i32 %21, 1
  store i32 %22, ptr @_ZZ4mainE4tick, align 4
  %23 = load i32, ptr %1, align 4
  ret i32 %23
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @_ZL10store_rarePc(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  store i8 44, ptr %3, align 1
  ret void
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @_ZL12store_commonPc(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  store i8 37, ptr %3, align 1
  ret void
}

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

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias writeonly captures(none), ptr noalias readonly captures(none), i64, i1 immarg) #2

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { mustprogress noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 5]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Homebrew clang version 21.1.8"}
