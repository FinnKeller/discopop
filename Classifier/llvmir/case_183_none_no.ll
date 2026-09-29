; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_183_none_no/case_183_none_no.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_183_none_no/case_183_none_no.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%class.anon = type { i8 }

@_ZL6g_cell = internal global i32 0, align 4
@__const.main.sink_table = private unnamed_addr constant [4 x ptr] [ptr @_ZL11store_valuePj, ptr @_ZL11store_valuePj, ptr @_ZL11store_valuePj, ptr @_ZL11store_valuePj], align 8

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca [4 x ptr], align 8
  %4 = alloca %class.anon, align 1
  %5 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr @_ZL6g_cell, align 4
  store i32 0, ptr %2, align 4
  %6 = call i32 @rand()
  %7 = srem i32 %6, 2
  %8 = icmp eq i32 %7, 0
  br i1 %8, label %9, label %10

9:                                                ; preds = %0
  store i32 1, ptr %2, align 4
  br label %11

10:                                               ; preds = %0
  store i32 2, ptr %2, align 4
  br label %11

11:                                               ; preds = %10, %9
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %3, ptr align 8 @__const.main.sink_table, i64 32, i1 false)
  %12 = call i32 @rand()
  %13 = srem i32 %12, 4
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds [4 x ptr], ptr %3, i64 0, i64 %14
  %16 = load ptr, ptr %15, align 8
  call void %16(ptr noundef @_ZL6g_cell)
  %17 = call noundef i32 @"_ZZ4mainENK3$_0clEPKj"(ptr noundef nonnull align 1 dereferenceable(1) %4, ptr noundef @_ZL6g_cell)
  store i32 %17, ptr %5, align 4
  %18 = load i32, ptr %1, align 4
  ret i32 %18
}

declare i32 @rand() #1

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @_ZL11store_valuePj(ptr noundef %0) #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  store i32 36, ptr %3, align 4
  ret void
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias writeonly captures(none), ptr noalias readonly captures(none), i64, i1 immarg) #3

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal noundef i32 @"_ZZ4mainENK3$_0clEPKj"(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef %1) #2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = load i32, ptr %6, align 4
  ret i32 %7
}

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { mustprogress noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 5]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Homebrew clang version 21.1.8"}
