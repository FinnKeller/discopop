; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_099_bothvol_yes/case_099_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_099_bothvol_yes/case_099_bothvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct.Codec = type { ptr, ptr }

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca [3 x %struct.Codec], align 8
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = getelementptr inbounds [3 x %struct.Codec], ptr %1, i64 0, i64 0
  %6 = getelementptr inbounds nuw %struct.Codec, ptr %5, i32 0, i32 0
  store ptr @_ZL8encode_aPi, ptr %6, align 8
  %7 = getelementptr inbounds [3 x %struct.Codec], ptr %1, i64 0, i64 0
  %8 = getelementptr inbounds nuw %struct.Codec, ptr %7, i32 0, i32 1
  store ptr @_ZL8decode_aPKi, ptr %8, align 8
  %9 = getelementptr inbounds [3 x %struct.Codec], ptr %1, i64 0, i64 1
  %10 = getelementptr inbounds nuw %struct.Codec, ptr %9, i32 0, i32 0
  store ptr @_ZL8encode_bPi, ptr %10, align 8
  %11 = getelementptr inbounds [3 x %struct.Codec], ptr %1, i64 0, i64 1
  %12 = getelementptr inbounds nuw %struct.Codec, ptr %11, i32 0, i32 1
  store ptr @_ZL8decode_bPKi, ptr %12, align 8
  %13 = getelementptr inbounds [3 x %struct.Codec], ptr %1, i64 0, i64 2
  %14 = getelementptr inbounds nuw %struct.Codec, ptr %13, i32 0, i32 0
  store ptr @_ZL8encode_cPi, ptr %14, align 8
  %15 = getelementptr inbounds [3 x %struct.Codec], ptr %1, i64 0, i64 2
  %16 = getelementptr inbounds nuw %struct.Codec, ptr %15, i32 0, i32 1
  store ptr @_ZL8decode_cPKi, ptr %16, align 8
  store i32 0, ptr %2, align 4
  %17 = load i32, ptr @_ZZ4mainE4tick, align 4
  %18 = srem i32 %17, 3
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds [3 x %struct.Codec], ptr %1, i64 0, i64 %19
  store ptr %20, ptr %3, align 8
  %21 = load ptr, ptr %3, align 8
  %22 = getelementptr inbounds nuw %struct.Codec, ptr %21, i32 0, i32 0
  %23 = load ptr, ptr %22, align 8
  call void %23(ptr noundef %2)
  %24 = load ptr, ptr %3, align 8
  %25 = getelementptr inbounds nuw %struct.Codec, ptr %24, i32 0, i32 1
  %26 = load ptr, ptr %25, align 8
  %27 = call noundef i32 %26(ptr noundef %2)
  store i32 %27, ptr %4, align 4
  %28 = load i32, ptr @_ZZ4mainE4tick, align 4
  %29 = add nsw i32 %28, 1
  store i32 %29, ptr @_ZZ4mainE4tick, align 4
  ret i32 0
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @_ZL8encode_aPi(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  store i32 5, ptr %3, align 4
  ret void
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal noundef i32 @_ZL8decode_aPKi(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = load i32, ptr %3, align 4
  %5 = add nsw i32 %4, 1
  ret i32 %5
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @_ZL8encode_bPi(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  store i32 6, ptr %3, align 4
  ret void
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal noundef i32 @_ZL8decode_bPKi(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = load i32, ptr %3, align 4
  %5 = add nsw i32 %4, 2
  ret i32 %5
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @_ZL8encode_cPi(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  store i32 7, ptr %3, align 4
  ret void
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal noundef i32 @_ZL8decode_cPKi(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = load i32, ptr %3, align 4
  %5 = add nsw i32 %4, 3
  ret i32 %5
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
