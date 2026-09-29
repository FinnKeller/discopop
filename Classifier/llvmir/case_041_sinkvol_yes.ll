; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_041_sinkvol_yes/case_041_sinkvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_041_sinkvol_yes/case_041_sinkvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct.Item = type { i32, ptr }

@_ZZ4mainE4tick = internal global i32 0, align 4

; Function Attrs: mustprogress noinline norecurse nounwind ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.Item, align 8
  %3 = alloca %struct.Item, align 8
  %4 = alloca %struct.Item, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %8 = getelementptr inbounds nuw %struct.Item, ptr %2, i32 0, i32 1
  store ptr %3, ptr %8, align 8
  %9 = getelementptr inbounds nuw %struct.Item, ptr %3, i32 0, i32 1
  store ptr %4, ptr %9, align 8
  %10 = getelementptr inbounds nuw %struct.Item, ptr %4, i32 0, i32 1
  store ptr null, ptr %10, align 8
  store ptr %2, ptr %5, align 8
  store i32 0, ptr %6, align 4
  br label %11

11:                                               ; preds = %14, %0
  %12 = load ptr, ptr %5, align 8
  %13 = icmp ne ptr %12, null
  br i1 %13, label %14, label %23

14:                                               ; preds = %11
  %15 = load i32, ptr %6, align 4
  %16 = load ptr, ptr %5, align 8
  %17 = getelementptr inbounds nuw %struct.Item, ptr %16, i32 0, i32 0
  store i32 %15, ptr %17, align 8
  %18 = load i32, ptr %6, align 4
  %19 = add nsw i32 %18, 1
  store i32 %19, ptr %6, align 4
  %20 = load ptr, ptr %5, align 8
  %21 = getelementptr inbounds nuw %struct.Item, ptr %20, i32 0, i32 1
  %22 = load ptr, ptr %21, align 8
  store ptr %22, ptr %5, align 8
  br label %11, !llvm.loop !6

23:                                               ; preds = %11
  %24 = load i32, ptr @_ZZ4mainE4tick, align 4
  %25 = srem i32 %24, 29
  %26 = icmp eq i32 %25, 9
  br i1 %26, label %27, label %29

27:                                               ; preds = %23
  %28 = getelementptr inbounds nuw %struct.Item, ptr %3, i32 0, i32 0
  store i32 555, ptr %28, align 8
  br label %29

29:                                               ; preds = %27, %23
  store i32 0, ptr %7, align 4
  store ptr %2, ptr %5, align 8
  br label %30

30:                                               ; preds = %33, %29
  %31 = load ptr, ptr %5, align 8
  %32 = icmp ne ptr %31, null
  br i1 %32, label %33, label %42

33:                                               ; preds = %30
  %34 = load ptr, ptr %5, align 8
  %35 = getelementptr inbounds nuw %struct.Item, ptr %34, i32 0, i32 0
  %36 = load i32, ptr %35, align 8
  %37 = load i32, ptr %7, align 4
  %38 = add nsw i32 %37, %36
  store i32 %38, ptr %7, align 4
  %39 = load ptr, ptr %5, align 8
  %40 = getelementptr inbounds nuw %struct.Item, ptr %39, i32 0, i32 1
  %41 = load ptr, ptr %40, align 8
  store ptr %41, ptr %5, align 8
  br label %30, !llvm.loop !8

42:                                               ; preds = %30
  %43 = load i32, ptr @_ZZ4mainE4tick, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, ptr @_ZZ4mainE4tick, align 4
  %45 = load i32, ptr %1, align 4
  ret i32 %45
}

attributes #0 = { mustprogress noinline norecurse nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }

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
