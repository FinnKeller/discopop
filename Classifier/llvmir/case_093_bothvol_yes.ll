; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_093_bothvol_yes/case_093_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_093_bothvol_yes/case_093_bothvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %10 = call noalias noundef nonnull ptr @_Znam(i64 noundef 32) #4
  store ptr %10, ptr %2, align 8
  %11 = call noalias noundef nonnull ptr @_Znam(i64 noundef 32) #4
  store ptr %11, ptr %3, align 8
  %12 = call i32 @rand()
  %13 = srem i32 %12, 2
  %14 = icmp eq i32 %13, 0
  %15 = zext i1 %14 to i64
  %16 = select i1 %14, i32 1, i32 0
  store i32 %16, ptr %4, align 4
  %17 = load i32, ptr %4, align 4
  %18 = icmp eq i32 %17, 1
  br i1 %18, label %19, label %34

19:                                               ; preds = %0
  store i32 0, ptr %5, align 4
  br label %20

20:                                               ; preds = %30, %19
  %21 = load i32, ptr %5, align 4
  %22 = icmp slt i32 %21, 8
  br i1 %22, label %23, label %33

23:                                               ; preds = %20
  %24 = load i32, ptr %5, align 4
  %25 = add nsw i32 %24, 1
  %26 = load ptr, ptr %2, align 8
  %27 = load i32, ptr %5, align 4
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds i32, ptr %26, i64 %28
  store i32 %25, ptr %29, align 4
  br label %30

30:                                               ; preds = %23
  %31 = load i32, ptr %5, align 4
  %32 = add nsw i32 %31, 1
  store i32 %32, ptr %5, align 4
  br label %20, !llvm.loop !6

33:                                               ; preds = %20
  br label %49

34:                                               ; preds = %0
  store i32 0, ptr %6, align 4
  br label %35

35:                                               ; preds = %45, %34
  %36 = load i32, ptr %6, align 4
  %37 = icmp slt i32 %36, 8
  br i1 %37, label %38, label %48

38:                                               ; preds = %35
  %39 = load i32, ptr %6, align 4
  %40 = add nsw i32 %39, 2
  %41 = load ptr, ptr %3, align 8
  %42 = load i32, ptr %6, align 4
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds i32, ptr %41, i64 %43
  store i32 %40, ptr %44, align 4
  br label %45

45:                                               ; preds = %38
  %46 = load i32, ptr %6, align 4
  %47 = add nsw i32 %46, 1
  store i32 %47, ptr %6, align 4
  br label %35, !llvm.loop !8

48:                                               ; preds = %35
  br label %49

49:                                               ; preds = %48, %33
  store i32 0, ptr %7, align 4
  %50 = load i32, ptr %4, align 4
  %51 = icmp eq i32 %50, 1
  br i1 %51, label %52, label %68

52:                                               ; preds = %49
  store i32 0, ptr %8, align 4
  br label %53

53:                                               ; preds = %64, %52
  %54 = load i32, ptr %8, align 4
  %55 = icmp slt i32 %54, 8
  br i1 %55, label %56, label %67

56:                                               ; preds = %53
  %57 = load ptr, ptr %2, align 8
  %58 = load i32, ptr %8, align 4
  %59 = sext i32 %58 to i64
  %60 = getelementptr inbounds i32, ptr %57, i64 %59
  %61 = load i32, ptr %60, align 4
  %62 = load i32, ptr %7, align 4
  %63 = add nsw i32 %62, %61
  store i32 %63, ptr %7, align 4
  br label %64

64:                                               ; preds = %56
  %65 = load i32, ptr %8, align 4
  %66 = add nsw i32 %65, 1
  store i32 %66, ptr %8, align 4
  br label %53, !llvm.loop !9

67:                                               ; preds = %53
  br label %84

68:                                               ; preds = %49
  store i32 0, ptr %9, align 4
  br label %69

69:                                               ; preds = %80, %68
  %70 = load i32, ptr %9, align 4
  %71 = icmp slt i32 %70, 8
  br i1 %71, label %72, label %83

72:                                               ; preds = %69
  %73 = load ptr, ptr %3, align 8
  %74 = load i32, ptr %9, align 4
  %75 = sext i32 %74 to i64
  %76 = getelementptr inbounds i32, ptr %73, i64 %75
  %77 = load i32, ptr %76, align 4
  %78 = load i32, ptr %7, align 4
  %79 = add nsw i32 %78, %77
  store i32 %79, ptr %7, align 4
  br label %80

80:                                               ; preds = %72
  %81 = load i32, ptr %9, align 4
  %82 = add nsw i32 %81, 1
  store i32 %82, ptr %9, align 4
  br label %69, !llvm.loop !10

83:                                               ; preds = %69
  br label %84

84:                                               ; preds = %83, %67
  %85 = load ptr, ptr %2, align 8
  %86 = icmp eq ptr %85, null
  br i1 %86, label %88, label %87

87:                                               ; preds = %84
  call void @_ZdaPv(ptr noundef %85) #5
  br label %88

88:                                               ; preds = %87, %84
  %89 = load ptr, ptr %3, align 8
  %90 = icmp eq ptr %89, null
  br i1 %90, label %92, label %91

91:                                               ; preds = %88
  call void @_ZdaPv(ptr noundef %89) #5
  br label %92

92:                                               ; preds = %91, %88
  %93 = load i32, ptr %1, align 4
  ret i32 %93
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
!10 = distinct !{!10, !7}
