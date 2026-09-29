; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_059_srcvol_yes/case_059_srcvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_059_srcvol_yes/case_059_srcvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [12 x i32], align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %3, align 4
  br label %7

7:                                                ; preds = %17, %0
  %8 = load i32, ptr %3, align 4
  %9 = icmp slt i32 %8, 12
  br i1 %9, label %10, label %20

10:                                               ; preds = %7
  %11 = load i32, ptr %3, align 4
  %12 = load i32, ptr %3, align 4
  %13 = mul nsw i32 %11, %12
  %14 = load i32, ptr %3, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds [12 x i32], ptr %2, i64 0, i64 %15
  store i32 %13, ptr %16, align 4
  br label %17

17:                                               ; preds = %10
  %18 = load i32, ptr %3, align 4
  %19 = add nsw i32 %18, 1
  store i32 %19, ptr %3, align 4
  br label %7, !llvm.loop !6

20:                                               ; preds = %7
  store i32 0, ptr %4, align 4
  %21 = call i32 @rand()
  %22 = srem i32 %21, 2
  %23 = icmp eq i32 %22, 0
  br i1 %23, label %24, label %40

24:                                               ; preds = %20
  %25 = getelementptr inbounds [12 x i32], ptr %2, i64 0, i64 0
  store ptr %25, ptr %5, align 8
  br label %26

26:                                               ; preds = %36, %24
  %27 = load ptr, ptr %5, align 8
  %28 = getelementptr inbounds [12 x i32], ptr %2, i64 0, i64 0
  %29 = getelementptr inbounds i32, ptr %28, i64 12
  %30 = icmp ult ptr %27, %29
  br i1 %30, label %31, label %39

31:                                               ; preds = %26
  %32 = load ptr, ptr %5, align 8
  %33 = load i32, ptr %32, align 4
  %34 = load i32, ptr %4, align 4
  %35 = add nsw i32 %34, %33
  store i32 %35, ptr %4, align 4
  br label %36

36:                                               ; preds = %31
  %37 = load ptr, ptr %5, align 8
  %38 = getelementptr inbounds nuw i32, ptr %37, i32 1
  store ptr %38, ptr %5, align 8
  br label %26, !llvm.loop !8

39:                                               ; preds = %26
  br label %55

40:                                               ; preds = %20
  store i32 0, ptr %6, align 4
  br label %41

41:                                               ; preds = %51, %40
  %42 = load i32, ptr %6, align 4
  %43 = icmp slt i32 %42, 12
  br i1 %43, label %44, label %54

44:                                               ; preds = %41
  %45 = load i32, ptr %6, align 4
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds [12 x i32], ptr %2, i64 0, i64 %46
  %48 = load i32, ptr %47, align 4
  %49 = load i32, ptr %4, align 4
  %50 = add nsw i32 %49, %48
  store i32 %50, ptr %4, align 4
  br label %51

51:                                               ; preds = %44
  %52 = load i32, ptr %6, align 4
  %53 = add nsw i32 %52, 1
  store i32 %53, ptr %6, align 4
  br label %41, !llvm.loop !9

54:                                               ; preds = %41
  br label %55

55:                                               ; preds = %54, %39
  %56 = load i32, ptr %1, align 4
  ret i32 %56
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
!9 = distinct !{!9, !7}
