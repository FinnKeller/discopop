; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_574_bothvol_yes/case_574_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_574_bothvol_yes/case_574_bothvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

%union.Slot = type { i32 }

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %union.Slot, align 4
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store ptr @_ZL12store_commonPj, ptr %3, align 8
  %7 = load i32, ptr @_ZZ4mainE4tick, align 4
  %8 = srem i32 %7, 37
  %9 = icmp eq i32 %8, 11
  br i1 %9, label %10, label %11

10:                                               ; preds = %0
  store ptr @_ZL10store_rarePj, ptr %3, align 8
  br label %11

11:                                               ; preds = %10, %0
  %12 = load ptr, ptr %3, align 8
  call void %12(ptr noundef %2)
  store i32 0, ptr %4, align 4
  %13 = load i32, ptr @_ZZ4mainE4tick, align 4
  %14 = srem i32 %13, 41
  %15 = icmp eq i32 %14, 23
  br i1 %15, label %16, label %32

16:                                               ; preds = %11
  store i32 0, ptr %5, align 4
  br label %17

17:                                               ; preds = %28, %16
  %18 = load i32, ptr %5, align 4
  %19 = icmp slt i32 %18, 16
  br i1 %19, label %20, label %31

20:                                               ; preds = %17
  %21 = load i32, ptr %5, align 4
  %22 = icmp eq i32 %21, 7
  br i1 %22, label %23, label %27

23:                                               ; preds = %20
  %24 = load i32, ptr %2, align 4
  %25 = load i32, ptr %4, align 4
  %26 = add i32 %25, %24
  store i32 %26, ptr %4, align 4
  br label %27

27:                                               ; preds = %23, %20
  br label %28

28:                                               ; preds = %27
  %29 = load i32, ptr %5, align 4
  %30 = add nsw i32 %29, 1
  store i32 %30, ptr %5, align 4
  br label %17, !llvm.loop !5

31:                                               ; preds = %17
  br label %48

32:                                               ; preds = %11
  store i32 0, ptr %6, align 4
  br label %33

33:                                               ; preds = %44, %32
  %34 = load i32, ptr %6, align 4
  %35 = icmp slt i32 %34, 16
  br i1 %35, label %36, label %47

36:                                               ; preds = %33
  %37 = load i32, ptr %6, align 4
  %38 = icmp eq i32 %37, 7
  br i1 %38, label %39, label %43

39:                                               ; preds = %36
  %40 = load i32, ptr %2, align 4
  %41 = load i32, ptr %4, align 4
  %42 = add i32 %41, %40
  store i32 %42, ptr %4, align 4
  br label %43

43:                                               ; preds = %39, %36
  br label %44

44:                                               ; preds = %43
  %45 = load i32, ptr %6, align 4
  %46 = add nsw i32 %45, 7
  store i32 %46, ptr %6, align 4
  br label %33, !llvm.loop !7

47:                                               ; preds = %33
  br label %48

48:                                               ; preds = %47, %31
  %49 = load i32, ptr @_ZZ4mainE4tick, align 4
  %50 = add nsw i32 %49, 1
  store i32 %50, ptr @_ZZ4mainE4tick, align 4
  %51 = load i32, ptr %1, align 4
  ret i32 %51
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @_ZL12store_commonPj(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  store i32 74, ptr %3, align 4
  ret void
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @_ZL10store_rarePj(ptr noundef %0) #1 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  store i32 81, ptr %3, align 4
  ret void
}

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #1 = { mustprogress noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 16.0.6"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
!7 = distinct !{!7, !6}
