; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_067_srcvol_yes/case_067_srcvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_067_srcvol_yes/case_067_srcvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct.Entry = type { i32, i32 }

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [4 x %struct.Entry], align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %3, align 4
  br label %7

7:                                                ; preds = %20, %0
  %8 = load i32, ptr %3, align 4
  %9 = icmp slt i32 %8, 4
  br i1 %9, label %10, label %23

10:                                               ; preds = %7
  %11 = load i32, ptr %3, align 4
  %12 = load i32, ptr %3, align 4
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds [4 x %struct.Entry], ptr %2, i64 0, i64 %13
  %15 = getelementptr inbounds nuw %struct.Entry, ptr %14, i32 0, i32 0
  store i32 %11, ptr %15, align 4
  %16 = load i32, ptr %3, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [4 x %struct.Entry], ptr %2, i64 0, i64 %17
  %19 = getelementptr inbounds nuw %struct.Entry, ptr %18, i32 0, i32 1
  store i32 0, ptr %19, align 4
  br label %20

20:                                               ; preds = %10
  %21 = load i32, ptr %3, align 4
  %22 = add nsw i32 %21, 1
  store i32 %22, ptr %3, align 4
  br label %7, !llvm.loop !6

23:                                               ; preds = %7
  %24 = call i32 @rand()
  %25 = srem i32 %24, 4
  store i32 %25, ptr %4, align 4
  %26 = load i32, ptr %4, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds [4 x %struct.Entry], ptr %2, i64 0, i64 %27
  %29 = getelementptr inbounds nuw %struct.Entry, ptr %28, i32 0, i32 1
  store i32 67, ptr %29, align 4
  store i32 0, ptr %5, align 4
  %30 = call i32 @rand()
  %31 = srem i32 %30, 3
  store i32 %31, ptr %6, align 4
  %32 = load i32, ptr %6, align 4
  %33 = icmp eq i32 %32, 0
  br i1 %33, label %34, label %40

34:                                               ; preds = %23
  %35 = load i32, ptr %4, align 4
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds [4 x %struct.Entry], ptr %2, i64 0, i64 %36
  %38 = getelementptr inbounds nuw %struct.Entry, ptr %37, i32 0, i32 1
  %39 = load i32, ptr %38, align 4
  store i32 %39, ptr %5, align 4
  br label %58

40:                                               ; preds = %23
  %41 = load i32, ptr %6, align 4
  %42 = icmp eq i32 %41, 1
  br i1 %42, label %43, label %50

43:                                               ; preds = %40
  %44 = load i32, ptr %4, align 4
  %45 = sext i32 %44 to i64
  %46 = getelementptr inbounds [4 x %struct.Entry], ptr %2, i64 0, i64 %45
  %47 = getelementptr inbounds nuw %struct.Entry, ptr %46, i32 0, i32 1
  %48 = load i32, ptr %47, align 4
  %49 = add nsw i32 %48, 1
  store i32 %49, ptr %5, align 4
  br label %57

50:                                               ; preds = %40
  %51 = load i32, ptr %4, align 4
  %52 = sext i32 %51 to i64
  %53 = getelementptr inbounds [4 x %struct.Entry], ptr %2, i64 0, i64 %52
  %54 = getelementptr inbounds nuw %struct.Entry, ptr %53, i32 0, i32 1
  %55 = load i32, ptr %54, align 4
  %56 = mul nsw i32 %55, 2
  store i32 %56, ptr %5, align 4
  br label %57

57:                                               ; preds = %50, %43
  br label %58

58:                                               ; preds = %57, %34
  %59 = load i32, ptr %1, align 4
  ret i32 %59
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
