; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_091_bothvol_yes/case_091_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_091_bothvol_yes/case_091_bothvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct.Slot = type { i32, ptr }

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.Slot, align 8
  %3 = alloca %struct.Slot, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  store i32 0, ptr %1, align 4
  %8 = getelementptr inbounds nuw %struct.Slot, ptr %2, i32 0, i32 1
  store ptr %3, ptr %8, align 8
  %9 = getelementptr inbounds nuw %struct.Slot, ptr %3, i32 0, i32 1
  store ptr null, ptr %9, align 8
  %10 = getelementptr inbounds nuw %struct.Slot, ptr %2, i32 0, i32 0
  store i32 0, ptr %10, align 8
  %11 = getelementptr inbounds nuw %struct.Slot, ptr %3, i32 0, i32 0
  store i32 0, ptr %11, align 8
  %12 = call i32 @rand()
  %13 = srem i32 %12, 2
  %14 = icmp eq i32 %13, 0
  br i1 %14, label %15, label %29

15:                                               ; preds = %0
  store ptr %2, ptr %4, align 8
  store i32 1, ptr %5, align 4
  br label %16

16:                                               ; preds = %19, %15
  %17 = load ptr, ptr %4, align 8
  %18 = icmp ne ptr %17, null
  br i1 %18, label %19, label %28

19:                                               ; preds = %16
  %20 = load i32, ptr %5, align 4
  %21 = load ptr, ptr %4, align 8
  %22 = getelementptr inbounds nuw %struct.Slot, ptr %21, i32 0, i32 0
  store i32 %20, ptr %22, align 8
  %23 = load i32, ptr %5, align 4
  %24 = add nsw i32 %23, 1
  store i32 %24, ptr %5, align 4
  %25 = load ptr, ptr %4, align 8
  %26 = getelementptr inbounds nuw %struct.Slot, ptr %25, i32 0, i32 1
  %27 = load ptr, ptr %26, align 8
  store ptr %27, ptr %4, align 8
  br label %16, !llvm.loop !6

28:                                               ; preds = %16
  br label %31

29:                                               ; preds = %0
  %30 = getelementptr inbounds nuw %struct.Slot, ptr %3, i32 0, i32 0
  store i32 9, ptr %30, align 8
  br label %31

31:                                               ; preds = %29, %28
  store i32 0, ptr %6, align 4
  %32 = call i32 @rand()
  %33 = srem i32 %32, 2
  %34 = icmp eq i32 %33, 0
  br i1 %34, label %35, label %49

35:                                               ; preds = %31
  store ptr %2, ptr %7, align 8
  br label %36

36:                                               ; preds = %39, %35
  %37 = load ptr, ptr %7, align 8
  %38 = icmp ne ptr %37, null
  br i1 %38, label %39, label %48

39:                                               ; preds = %36
  %40 = load ptr, ptr %7, align 8
  %41 = getelementptr inbounds nuw %struct.Slot, ptr %40, i32 0, i32 0
  %42 = load i32, ptr %41, align 8
  %43 = load i32, ptr %6, align 4
  %44 = add nsw i32 %43, %42
  store i32 %44, ptr %6, align 4
  %45 = load ptr, ptr %7, align 8
  %46 = getelementptr inbounds nuw %struct.Slot, ptr %45, i32 0, i32 1
  %47 = load ptr, ptr %46, align 8
  store ptr %47, ptr %7, align 8
  br label %36, !llvm.loop !8

48:                                               ; preds = %36
  br label %54

49:                                               ; preds = %31
  %50 = getelementptr inbounds nuw %struct.Slot, ptr %3, i32 0, i32 0
  %51 = load i32, ptr %50, align 8
  %52 = load i32, ptr %6, align 4
  %53 = add nsw i32 %52, %51
  store i32 %53, ptr %6, align 4
  br label %54

54:                                               ; preds = %49, %48
  %55 = load i32, ptr %1, align 4
  ret i32 %55
}

declare i32 @rand() #1

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }

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
