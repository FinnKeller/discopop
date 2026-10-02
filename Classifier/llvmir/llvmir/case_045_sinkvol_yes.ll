; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_045_sinkvol_yes/case_045_sinkvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_045_sinkvol_yes/case_045_sinkvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

%struct.TreeNode = type { i32, ptr, ptr }

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.TreeNode, align 8
  %3 = alloca %struct.TreeNode, align 8
  %4 = alloca %struct.TreeNode, align 8
  %5 = alloca %struct.TreeNode, align 8
  %6 = alloca %struct.TreeNode, align 8
  %7 = alloca %struct.TreeNode, align 8
  %8 = alloca %struct.TreeNode, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %13 = getelementptr inbounds %struct.TreeNode, ptr %2, i32 0, i32 1
  store ptr null, ptr %13, align 8
  %14 = getelementptr inbounds %struct.TreeNode, ptr %2, i32 0, i32 2
  store ptr null, ptr %14, align 8
  %15 = getelementptr inbounds %struct.TreeNode, ptr %3, i32 0, i32 1
  store ptr null, ptr %15, align 8
  %16 = getelementptr inbounds %struct.TreeNode, ptr %3, i32 0, i32 2
  store ptr null, ptr %16, align 8
  %17 = getelementptr inbounds %struct.TreeNode, ptr %4, i32 0, i32 1
  store ptr null, ptr %17, align 8
  %18 = getelementptr inbounds %struct.TreeNode, ptr %4, i32 0, i32 2
  store ptr null, ptr %18, align 8
  %19 = getelementptr inbounds %struct.TreeNode, ptr %5, i32 0, i32 1
  store ptr null, ptr %19, align 8
  %20 = getelementptr inbounds %struct.TreeNode, ptr %5, i32 0, i32 2
  store ptr null, ptr %20, align 8
  %21 = getelementptr inbounds %struct.TreeNode, ptr %6, i32 0, i32 1
  store ptr %2, ptr %21, align 8
  %22 = getelementptr inbounds %struct.TreeNode, ptr %6, i32 0, i32 2
  store ptr %3, ptr %22, align 8
  %23 = getelementptr inbounds %struct.TreeNode, ptr %7, i32 0, i32 1
  store ptr %4, ptr %23, align 8
  %24 = getelementptr inbounds %struct.TreeNode, ptr %7, i32 0, i32 2
  store ptr %5, ptr %24, align 8
  %25 = getelementptr inbounds %struct.TreeNode, ptr %8, i32 0, i32 1
  store ptr %6, ptr %25, align 8
  %26 = getelementptr inbounds %struct.TreeNode, ptr %8, i32 0, i32 2
  store ptr %7, ptr %26, align 8
  %27 = call i32 @rand()
  %28 = srem i32 %27, 2
  store i32 %28, ptr %9, align 4
  %29 = call i32 @rand()
  %30 = srem i32 %29, 2
  store i32 %30, ptr %10, align 4
  %31 = load i32, ptr %9, align 4
  %32 = icmp eq i32 %31, 0
  br i1 %32, label %33, label %38

33:                                               ; preds = %0
  %34 = load i32, ptr %10, align 4
  %35 = icmp eq i32 %34, 0
  br i1 %35, label %36, label %38

36:                                               ; preds = %33
  %37 = getelementptr inbounds %struct.TreeNode, ptr %2, i32 0, i32 0
  store i32 1, ptr %37, align 8
  br label %52

38:                                               ; preds = %33, %0
  %39 = load i32, ptr %9, align 4
  %40 = icmp eq i32 %39, 0
  br i1 %40, label %41, label %43

41:                                               ; preds = %38
  %42 = getelementptr inbounds %struct.TreeNode, ptr %3, i32 0, i32 0
  store i32 2, ptr %42, align 8
  br label %51

43:                                               ; preds = %38
  %44 = load i32, ptr %10, align 4
  %45 = icmp eq i32 %44, 0
  br i1 %45, label %46, label %48

46:                                               ; preds = %43
  %47 = getelementptr inbounds %struct.TreeNode, ptr %4, i32 0, i32 0
  store i32 3, ptr %47, align 8
  br label %50

48:                                               ; preds = %43
  %49 = getelementptr inbounds %struct.TreeNode, ptr %5, i32 0, i32 0
  store i32 4, ptr %49, align 8
  br label %50

50:                                               ; preds = %48, %46
  br label %51

51:                                               ; preds = %50, %41
  br label %52

52:                                               ; preds = %51, %36
  %53 = load i32, ptr %9, align 4
  %54 = icmp eq i32 %53, 0
  br i1 %54, label %55, label %58

55:                                               ; preds = %52
  %56 = getelementptr inbounds %struct.TreeNode, ptr %8, i32 0, i32 1
  %57 = load ptr, ptr %56, align 8
  br label %61

58:                                               ; preds = %52
  %59 = getelementptr inbounds %struct.TreeNode, ptr %8, i32 0, i32 2
  %60 = load ptr, ptr %59, align 8
  br label %61

61:                                               ; preds = %58, %55
  %62 = phi ptr [ %57, %55 ], [ %60, %58 ]
  store ptr %62, ptr %11, align 8
  %63 = load i32, ptr %10, align 4
  %64 = icmp eq i32 %63, 0
  br i1 %64, label %65, label %69

65:                                               ; preds = %61
  %66 = load ptr, ptr %11, align 8
  %67 = getelementptr inbounds %struct.TreeNode, ptr %66, i32 0, i32 1
  %68 = load ptr, ptr %67, align 8
  br label %73

69:                                               ; preds = %61
  %70 = load ptr, ptr %11, align 8
  %71 = getelementptr inbounds %struct.TreeNode, ptr %70, i32 0, i32 2
  %72 = load ptr, ptr %71, align 8
  br label %73

73:                                               ; preds = %69, %65
  %74 = phi ptr [ %68, %65 ], [ %72, %69 ]
  store ptr %74, ptr %11, align 8
  %75 = load ptr, ptr %11, align 8
  %76 = getelementptr inbounds %struct.TreeNode, ptr %75, i32 0, i32 0
  %77 = load i32, ptr %76, align 8
  store i32 %77, ptr %12, align 4
  %78 = load i32, ptr %1, align 4
  ret i32 %78
}

declare i32 @rand() #1

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 16.0.6"}
