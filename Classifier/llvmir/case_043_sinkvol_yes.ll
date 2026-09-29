; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_043_sinkvol_yes/case_043_sinkvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_043_sinkvol_yes/case_043_sinkvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %9 = call noalias noundef nonnull ptr @_Znam(i64 noundef 32) #4
  store ptr %9, ptr %2, align 8
  %10 = call noalias noundef nonnull ptr @_Znam(i64 noundef 32) #4
  store ptr %10, ptr %3, align 8
  store ptr null, ptr %4, align 8
  %11 = call i32 @rand()
  %12 = srem i32 %11, 2
  %13 = icmp eq i32 %12, 0
  br i1 %13, label %14, label %29

14:                                               ; preds = %0
  store i32 0, ptr %5, align 4
  br label %15

15:                                               ; preds = %24, %14
  %16 = load i32, ptr %5, align 4
  %17 = icmp slt i32 %16, 8
  br i1 %17, label %18, label %27

18:                                               ; preds = %15
  %19 = load i32, ptr %5, align 4
  %20 = load ptr, ptr %2, align 8
  %21 = load i32, ptr %5, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds i32, ptr %20, i64 %22
  store i32 %19, ptr %23, align 4
  br label %24

24:                                               ; preds = %18
  %25 = load i32, ptr %5, align 4
  %26 = add nsw i32 %25, 1
  store i32 %26, ptr %5, align 4
  br label %15, !llvm.loop !6

27:                                               ; preds = %15
  %28 = load ptr, ptr %2, align 8
  store ptr %28, ptr %4, align 8
  br label %45

29:                                               ; preds = %0
  store i32 0, ptr %6, align 4
  br label %30

30:                                               ; preds = %40, %29
  %31 = load i32, ptr %6, align 4
  %32 = icmp slt i32 %31, 8
  br i1 %32, label %33, label %43

33:                                               ; preds = %30
  %34 = load i32, ptr %6, align 4
  %35 = mul nsw i32 %34, 3
  %36 = load ptr, ptr %3, align 8
  %37 = load i32, ptr %6, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds i32, ptr %36, i64 %38
  store i32 %35, ptr %39, align 4
  br label %40

40:                                               ; preds = %33
  %41 = load i32, ptr %6, align 4
  %42 = add nsw i32 %41, 1
  store i32 %42, ptr %6, align 4
  br label %30, !llvm.loop !8

43:                                               ; preds = %30
  %44 = load ptr, ptr %3, align 8
  store ptr %44, ptr %4, align 8
  br label %45

45:                                               ; preds = %43, %27
  store i32 0, ptr %7, align 4
  store i32 0, ptr %8, align 4
  br label %46

46:                                               ; preds = %57, %45
  %47 = load i32, ptr %8, align 4
  %48 = icmp slt i32 %47, 8
  br i1 %48, label %49, label %60

49:                                               ; preds = %46
  %50 = load ptr, ptr %4, align 8
  %51 = load i32, ptr %8, align 4
  %52 = sext i32 %51 to i64
  %53 = getelementptr inbounds i32, ptr %50, i64 %52
  %54 = load i32, ptr %53, align 4
  %55 = load i32, ptr %7, align 4
  %56 = add nsw i32 %55, %54
  store i32 %56, ptr %7, align 4
  br label %57

57:                                               ; preds = %49
  %58 = load i32, ptr %8, align 4
  %59 = add nsw i32 %58, 1
  store i32 %59, ptr %8, align 4
  br label %46, !llvm.loop !9

60:                                               ; preds = %46
  %61 = load ptr, ptr %2, align 8
  %62 = icmp eq ptr %61, null
  br i1 %62, label %64, label %63

63:                                               ; preds = %60
  call void @_ZdaPv(ptr noundef %61) #5
  br label %64

64:                                               ; preds = %63, %60
  %65 = load ptr, ptr %3, align 8
  %66 = icmp eq ptr %65, null
  br i1 %66, label %68, label %67

67:                                               ; preds = %64
  call void @_ZdaPv(ptr noundef %65) #5
  br label %68

68:                                               ; preds = %67, %64
  %69 = load i32, ptr %1, align 4
  ret i32 %69
}

; Function Attrs: nobuiltin allocsize(0)
declare noundef nonnull ptr @_Znam(i64 noundef) #1

declare i32 @rand() #2

; Function Attrs: nobuiltin nounwind
declare void @_ZdaPv(ptr noundef) #3

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { nobuiltin allocsize(0) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { nobuiltin nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #4 = { builtin allocsize(0) }
attributes #5 = { builtin nounwind }

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
