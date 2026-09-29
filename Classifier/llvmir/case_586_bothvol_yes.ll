; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_586_bothvol_yes/case_586_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_586_bothvol_yes/case_586_bothvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%union.Slot = type { i8 }
%class.anon = type { i8 }
%class.anon.0 = type { i8 }

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %union.Slot, align 1
  %3 = alloca %class.anon, align 1
  %4 = alloca %class.anon.0, align 1
  %5 = alloca ptr, align 8
  %6 = alloca i8, align 1
  store i32 0, ptr %1, align 4
  %7 = load i32, ptr @_ZZ4mainE4tick, align 4
  %8 = srem i32 %7, 31
  %9 = icmp eq i32 %8, 7
  br i1 %9, label %10, label %11

10:                                               ; preds = %0
  call void @"_ZZ4mainENK3$_0clEPc"(ptr noundef nonnull align 1 dereferenceable(1) %4, ptr noundef %2)
  br label %12

11:                                               ; preds = %0
  call void @"_ZZ4mainENK3$_1clEPc"(ptr noundef nonnull align 1 dereferenceable(1) %3, ptr noundef %2)
  br label %12

12:                                               ; preds = %11, %10
  store ptr @_ZL11load_commonPKc, ptr %5, align 8
  %13 = load i32, ptr @_ZZ4mainE4tick, align 4
  %14 = srem i32 %13, 23
  %15 = icmp eq i32 %14, 11
  br i1 %15, label %16, label %17

16:                                               ; preds = %12
  store ptr @_ZL9load_rarePKc, ptr %5, align 8
  br label %17

17:                                               ; preds = %16, %12
  %18 = load ptr, ptr %5, align 8
  %19 = call noundef signext i8 %18(ptr noundef %2)
  store i8 %19, ptr %6, align 1
  %20 = load i32, ptr @_ZZ4mainE4tick, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr @_ZZ4mainE4tick, align 4
  %22 = load i32, ptr %1, align 4
  ret i32 %22
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @"_ZZ4mainENK3$_0clEPc"(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef %1) #1 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  store i8 85, ptr %6, align 1
  ret void
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @"_ZZ4mainENK3$_1clEPc"(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef %1) #1 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  store i8 78, ptr %6, align 1
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
