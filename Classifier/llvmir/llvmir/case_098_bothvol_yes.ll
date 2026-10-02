; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_098_bothvol_yes/case_098_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_098_bothvol_yes/case_098_bothvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

%class.anon = type { i8 }
%class.anon.0 = type { i8 }
%class.anon.2 = type { i8 }
%class.anon.4 = type { i8 }
%class.anon.6 = type { i8 }
%class.anon.8 = type { i8 }

@_ZZ4mainE4tick = internal global i32 0, align 4
@__const._ZL11pick_storeri.table = private unnamed_addr constant [3 x ptr] [ptr @"_ZZL11pick_storeriEN3$_08__invokeEPi", ptr @"_ZZL11pick_storeriEN3$_18__invokeEPi", ptr @"_ZZL11pick_storeriEN3$_28__invokeEPi"], align 8
@__const._ZL11pick_loaderi.table = private unnamed_addr constant [3 x ptr] [ptr @"_ZZL11pick_loaderiEN3$_08__invokeEPKi", ptr @"_ZZL11pick_loaderiEN3$_18__invokeEPKi", ptr @"_ZZL11pick_loaderiEN3$_28__invokeEPKi"], align 8

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %5 = load i32, ptr @_ZZ4mainE4tick, align 4
  %6 = srem i32 %5, 3
  %7 = call noundef ptr @_ZL11pick_storeri(i32 noundef %6)
  store ptr %7, ptr %2, align 8
  %8 = load i32, ptr @_ZZ4mainE4tick, align 4
  %9 = mul nsw i32 %8, 2
  %10 = srem i32 %9, 3
  %11 = call noundef ptr @_ZL11pick_loaderi(i32 noundef %10)
  store ptr %11, ptr %3, align 8
  %12 = load ptr, ptr %2, align 8
  call void %12(ptr noundef %1)
  %13 = load ptr, ptr %3, align 8
  %14 = call noundef i32 %13(ptr noundef %1)
  store i32 %14, ptr %4, align 4
  %15 = load i32, ptr @_ZZ4mainE4tick, align 4
  %16 = add nsw i32 %15, 1
  store i32 %16, ptr @_ZZ4mainE4tick, align 4
  ret i32 0
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal noundef ptr @_ZL11pick_storeri(i32 noundef %0) #1 {
  %2 = alloca i32, align 4
  %3 = alloca [3 x ptr], align 8
  store i32 %0, ptr %2, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %3, ptr align 8 @__const._ZL11pick_storeri.table, i64 24, i1 false)
  %4 = load i32, ptr %2, align 4
  %5 = sext i32 %4 to i64
  %6 = getelementptr inbounds [3 x ptr], ptr %3, i64 0, i64 %5
  %7 = load ptr, ptr %6, align 8
  ret ptr %7
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal noundef ptr @_ZL11pick_loaderi(i32 noundef %0) #1 {
  %2 = alloca i32, align 4
  %3 = alloca [3 x ptr], align 8
  store i32 %0, ptr %2, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %3, ptr align 8 @__const._ZL11pick_loaderi.table, i64 24, i1 false)
  %4 = load i32, ptr %2, align 4
  %5 = sext i32 %4 to i64
  %6 = getelementptr inbounds [3 x ptr], ptr %3, i64 0, i64 %5
  %7 = load ptr, ptr %6, align 8
  ret ptr %7
}

; Function Attrs: noinline ssp uwtable(sync)
define internal void @"_ZZL11pick_storeriEN3$_08__invokeEPi"(ptr noundef %0) #2 align 2 {
  %2 = alloca ptr, align 8
  %3 = alloca %class.anon, align 1
  store ptr %0, ptr %2, align 8
  %4 = load ptr, ptr %2, align 8
  call void @"_ZZL11pick_storeriENK3$_0clEPi"(ptr noundef nonnull align 1 dereferenceable(1) %3, ptr noundef %4)
  ret void
}

; Function Attrs: noinline ssp uwtable(sync)
define internal void @"_ZZL11pick_storeriEN3$_18__invokeEPi"(ptr noundef %0) #2 align 2 {
  %2 = alloca ptr, align 8
  %3 = alloca %class.anon.0, align 1
  store ptr %0, ptr %2, align 8
  %4 = load ptr, ptr %2, align 8
  call void @"_ZZL11pick_storeriENK3$_1clEPi"(ptr noundef nonnull align 1 dereferenceable(1) %3, ptr noundef %4)
  ret void
}

; Function Attrs: noinline ssp uwtable(sync)
define internal void @"_ZZL11pick_storeriEN3$_28__invokeEPi"(ptr noundef %0) #2 align 2 {
  %2 = alloca ptr, align 8
  %3 = alloca %class.anon.2, align 1
  store ptr %0, ptr %2, align 8
  %4 = load ptr, ptr %2, align 8
  call void @"_ZZL11pick_storeriENK3$_2clEPi"(ptr noundef nonnull align 1 dereferenceable(1) %3, ptr noundef %4)
  ret void
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #3

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @"_ZZL11pick_storeriENK3$_0clEPi"(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef %1) #1 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  store i32 1, ptr %6, align 4
  ret void
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @"_ZZL11pick_storeriENK3$_1clEPi"(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef %1) #1 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  store i32 2, ptr %6, align 4
  ret void
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @"_ZZL11pick_storeriENK3$_2clEPi"(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef %1) #1 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  store i32 3, ptr %6, align 4
  ret void
}

; Function Attrs: noinline ssp uwtable(sync)
define internal noundef i32 @"_ZZL11pick_loaderiEN3$_08__invokeEPKi"(ptr noundef %0) #2 align 2 {
  %2 = alloca ptr, align 8
  %3 = alloca %class.anon.4, align 1
  store ptr %0, ptr %2, align 8
  %4 = load ptr, ptr %2, align 8
  %5 = call noundef i32 @"_ZZL11pick_loaderiENK3$_0clEPKi"(ptr noundef nonnull align 1 dereferenceable(1) %3, ptr noundef %4)
  ret i32 %5
}

; Function Attrs: noinline ssp uwtable(sync)
define internal noundef i32 @"_ZZL11pick_loaderiEN3$_18__invokeEPKi"(ptr noundef %0) #2 align 2 {
  %2 = alloca ptr, align 8
  %3 = alloca %class.anon.6, align 1
  store ptr %0, ptr %2, align 8
  %4 = load ptr, ptr %2, align 8
  %5 = call noundef i32 @"_ZZL11pick_loaderiENK3$_1clEPKi"(ptr noundef nonnull align 1 dereferenceable(1) %3, ptr noundef %4)
  ret i32 %5
}

; Function Attrs: noinline ssp uwtable(sync)
define internal noundef i32 @"_ZZL11pick_loaderiEN3$_28__invokeEPKi"(ptr noundef %0) #2 align 2 {
  %2 = alloca ptr, align 8
  %3 = alloca %class.anon.8, align 1
  store ptr %0, ptr %2, align 8
  %4 = load ptr, ptr %2, align 8
  %5 = call noundef i32 @"_ZZL11pick_loaderiENK3$_2clEPKi"(ptr noundef nonnull align 1 dereferenceable(1) %3, ptr noundef %4)
  ret i32 %5
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal noundef i32 @"_ZZL11pick_loaderiENK3$_0clEPKi"(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef %1) #1 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = load i32, ptr %6, align 4
  %8 = add nsw i32 %7, 1
  ret i32 %8
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal noundef i32 @"_ZZL11pick_loaderiENK3$_1clEPKi"(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef %1) #1 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = load i32, ptr %6, align 4
  %8 = add nsw i32 %7, 2
  ret i32 %8
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal noundef i32 @"_ZZL11pick_loaderiENK3$_2clEPKi"(ptr noundef nonnull align 1 dereferenceable(1) %0, ptr noundef %1) #1 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = load i32, ptr %6, align 4
  %8 = add nsw i32 %7, 3
  ret i32 %8
}

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #1 = { mustprogress noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #2 = { noinline ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #3 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 16.0.6"}
