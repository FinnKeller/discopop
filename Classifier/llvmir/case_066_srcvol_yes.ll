; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_066_srcvol_yes/case_066_srcvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_066_srcvol_yes/case_066_srcvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct.Cell = type { i32, ptr }

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.Cell, align 8
  %3 = alloca %struct.Cell, align 8
  %4 = alloca %struct.Cell, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %8 = getelementptr inbounds nuw %struct.Cell, ptr %2, i32 0, i32 1
  store ptr %3, ptr %8, align 8
  %9 = getelementptr inbounds nuw %struct.Cell, ptr %3, i32 0, i32 1
  store ptr %4, ptr %9, align 8
  %10 = getelementptr inbounds nuw %struct.Cell, ptr %4, i32 0, i32 1
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
  %17 = getelementptr inbounds nuw %struct.Cell, ptr %16, i32 0, i32 0
  store i32 %15, ptr %17, align 8
  %18 = load i32, ptr %6, align 4
  %19 = add nsw i32 %18, 1
  store i32 %19, ptr %6, align 4
  %20 = load ptr, ptr %5, align 8
  %21 = getelementptr inbounds nuw %struct.Cell, ptr %20, i32 0, i32 1
  %22 = load ptr, ptr %21, align 8
  store ptr %22, ptr %5, align 8
  br label %11, !llvm.loop !6

23:                                               ; preds = %11
  store i32 0, ptr %7, align 4
  %24 = call i32 @rand()
  %25 = srem i32 %24, 2
  %26 = icmp eq i32 %25, 0
  br i1 %26, label %27, label %41

27:                                               ; preds = %23
  store ptr %2, ptr %5, align 8
  br label %28

28:                                               ; preds = %31, %27
  %29 = load ptr, ptr %5, align 8
  %30 = icmp ne ptr %29, null
  br i1 %30, label %31, label %40

31:                                               ; preds = %28
  %32 = load ptr, ptr %5, align 8
  %33 = getelementptr inbounds nuw %struct.Cell, ptr %32, i32 0, i32 0
  %34 = load i32, ptr %33, align 8
  %35 = load i32, ptr %7, align 4
  %36 = add nsw i32 %35, %34
  store i32 %36, ptr %7, align 4
  %37 = load ptr, ptr %5, align 8
  %38 = getelementptr inbounds nuw %struct.Cell, ptr %37, i32 0, i32 1
  %39 = load ptr, ptr %38, align 8
  store ptr %39, ptr %5, align 8
  br label %28, !llvm.loop !8

40:                                               ; preds = %28
  br label %54

41:                                               ; preds = %23
  %42 = getelementptr inbounds nuw %struct.Cell, ptr %2, i32 0, i32 0
  %43 = load i32, ptr %42, align 8
  %44 = load i32, ptr %7, align 4
  %45 = add nsw i32 %44, %43
  store i32 %45, ptr %7, align 4
  %46 = getelementptr inbounds nuw %struct.Cell, ptr %3, i32 0, i32 0
  %47 = load i32, ptr %46, align 8
  %48 = load i32, ptr %7, align 4
  %49 = add nsw i32 %48, %47
  store i32 %49, ptr %7, align 4
  %50 = getelementptr inbounds nuw %struct.Cell, ptr %4, i32 0, i32 0
  %51 = load i32, ptr %50, align 8
  %52 = load i32, ptr %7, align 4
  %53 = add nsw i32 %52, %51
  store i32 %53, ptr %7, align 4
  br label %54

54:                                               ; preds = %41, %40
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
