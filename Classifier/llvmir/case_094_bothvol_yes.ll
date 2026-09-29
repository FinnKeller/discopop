; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_094_bothvol_yes/case_094_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_094_bothvol_yes/case_094_bothvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct.Branch = type { i32, ptr, ptr }

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.Branch, align 8
  %3 = alloca %struct.Branch, align 8
  %4 = alloca %struct.Branch, align 8
  %5 = alloca %struct.Branch, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %9 = getelementptr inbounds nuw %struct.Branch, ptr %2, i32 0, i32 1
  store ptr null, ptr %9, align 8
  %10 = getelementptr inbounds nuw %struct.Branch, ptr %2, i32 0, i32 2
  store ptr null, ptr %10, align 8
  %11 = getelementptr inbounds nuw %struct.Branch, ptr %2, i32 0, i32 0
  store i32 0, ptr %11, align 8
  %12 = getelementptr inbounds nuw %struct.Branch, ptr %3, i32 0, i32 1
  store ptr null, ptr %12, align 8
  %13 = getelementptr inbounds nuw %struct.Branch, ptr %3, i32 0, i32 2
  store ptr null, ptr %13, align 8
  %14 = getelementptr inbounds nuw %struct.Branch, ptr %3, i32 0, i32 0
  store i32 0, ptr %14, align 8
  %15 = getelementptr inbounds nuw %struct.Branch, ptr %4, i32 0, i32 1
  store ptr null, ptr %15, align 8
  %16 = getelementptr inbounds nuw %struct.Branch, ptr %4, i32 0, i32 2
  store ptr null, ptr %16, align 8
  %17 = getelementptr inbounds nuw %struct.Branch, ptr %4, i32 0, i32 0
  store i32 0, ptr %17, align 8
  %18 = getelementptr inbounds nuw %struct.Branch, ptr %5, i32 0, i32 1
  store ptr null, ptr %18, align 8
  %19 = getelementptr inbounds nuw %struct.Branch, ptr %5, i32 0, i32 2
  store ptr null, ptr %19, align 8
  %20 = getelementptr inbounds nuw %struct.Branch, ptr %5, i32 0, i32 0
  store i32 0, ptr %20, align 8
  %21 = call i32 @rand()
  %22 = srem i32 %21, 2
  store i32 %22, ptr %6, align 4
  %23 = call i32 @rand()
  %24 = srem i32 %23, 2
  store i32 %24, ptr %7, align 4
  store i32 0, ptr %8, align 4
  %25 = load i32, ptr %6, align 4
  %26 = icmp eq i32 %25, 0
  br i1 %26, label %27, label %34

27:                                               ; preds = %0
  %28 = load i32, ptr %7, align 4
  %29 = icmp eq i32 %28, 0
  br i1 %29, label %30, label %34

30:                                               ; preds = %27
  %31 = getelementptr inbounds nuw %struct.Branch, ptr %2, i32 0, i32 0
  store i32 1, ptr %31, align 8
  %32 = getelementptr inbounds nuw %struct.Branch, ptr %2, i32 0, i32 0
  %33 = load i32, ptr %32, align 8
  store i32 %33, ptr %8, align 4
  br label %54

34:                                               ; preds = %27, %0
  %35 = load i32, ptr %6, align 4
  %36 = icmp eq i32 %35, 0
  br i1 %36, label %37, label %41

37:                                               ; preds = %34
  %38 = getelementptr inbounds nuw %struct.Branch, ptr %3, i32 0, i32 0
  store i32 2, ptr %38, align 8
  %39 = getelementptr inbounds nuw %struct.Branch, ptr %3, i32 0, i32 0
  %40 = load i32, ptr %39, align 8
  store i32 %40, ptr %8, align 4
  br label %53

41:                                               ; preds = %34
  %42 = load i32, ptr %7, align 4
  %43 = icmp eq i32 %42, 0
  br i1 %43, label %44, label %48

44:                                               ; preds = %41
  %45 = getelementptr inbounds nuw %struct.Branch, ptr %4, i32 0, i32 0
  store i32 3, ptr %45, align 8
  %46 = getelementptr inbounds nuw %struct.Branch, ptr %4, i32 0, i32 0
  %47 = load i32, ptr %46, align 8
  store i32 %47, ptr %8, align 4
  br label %52

48:                                               ; preds = %41
  %49 = getelementptr inbounds nuw %struct.Branch, ptr %5, i32 0, i32 0
  store i32 4, ptr %49, align 8
  %50 = getelementptr inbounds nuw %struct.Branch, ptr %5, i32 0, i32 0
  %51 = load i32, ptr %50, align 8
  store i32 %51, ptr %8, align 4
  br label %52

52:                                               ; preds = %48, %44
  br label %53

53:                                               ; preds = %52, %37
  br label %54

54:                                               ; preds = %53, %30
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
