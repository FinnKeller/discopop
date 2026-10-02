; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_075_srcvol_yes/case_075_srcvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_075_srcvol_yes/case_075_srcvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

%struct.CommonObserver = type { %struct.Observer }
%struct.Observer = type { ptr }
%struct.RareObserver = type { %struct.Observer }

@_ZZ4mainE4tick = internal global i32 0, align 4
@_ZL7scratch = internal global [32 x i32] zeroinitializer, align 4
@_ZTV14CommonObserver = linkonce_odr unnamed_addr constant { [5 x ptr] } { [5 x ptr] [ptr null, ptr @_ZTI14CommonObserver, ptr @_ZN14CommonObserver7observeEPKi, ptr @_ZN14CommonObserverD1Ev, ptr @_ZN14CommonObserverD0Ev] }, align 8
@_ZTVN10__cxxabiv120__si_class_type_infoE = external global ptr
@_ZTS14CommonObserver = linkonce_odr hidden constant [17 x i8] c"14CommonObserver\00", align 1
@_ZTVN10__cxxabiv117__class_type_infoE = external global ptr
@_ZTS8Observer = linkonce_odr hidden constant [10 x i8] c"8Observer\00", align 1
@_ZTI8Observer = linkonce_odr hidden constant { ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv117__class_type_infoE, i64 2), ptr inttoptr (i64 add (i64 ptrtoint (ptr @_ZTS8Observer to i64), i64 -9223372036854775808) to ptr) }, align 8
@_ZTI14CommonObserver = linkonce_odr hidden constant { ptr, ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2), ptr inttoptr (i64 add (i64 ptrtoint (ptr @_ZTS14CommonObserver to i64), i64 -9223372036854775808) to ptr), ptr @_ZTI8Observer }, align 8
@_ZTV8Observer = linkonce_odr unnamed_addr constant { [5 x ptr] } { [5 x ptr] [ptr null, ptr @_ZTI8Observer, ptr @__cxa_pure_virtual, ptr @_ZN8ObserverD1Ev, ptr @_ZN8ObserverD0Ev] }, align 8
@_ZTV12RareObserver = linkonce_odr unnamed_addr constant { [5 x ptr] } { [5 x ptr] [ptr null, ptr @_ZTI12RareObserver, ptr @_ZN12RareObserver7observeEPKi, ptr @_ZN12RareObserverD1Ev, ptr @_ZN12RareObserverD0Ev] }, align 8
@_ZTS12RareObserver = linkonce_odr hidden constant [15 x i8] c"12RareObserver\00", align 1
@_ZTI12RareObserver = linkonce_odr hidden constant { ptr, ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2), ptr inttoptr (i64 add (i64 ptrtoint (ptr @_ZTS12RareObserver to i64), i64 -9223372036854775808) to ptr), ptr @_ZTI8Observer }, align 8

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 personality ptr @__gxx_personality_v0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca %struct.CommonObserver, align 8
  %5 = alloca %struct.RareObserver, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %10 = load i32, ptr @_ZZ4mainE4tick, align 4
  %11 = srem i32 %10, 5
  %12 = add nsw i32 37, %11
  %13 = call noundef i32 @_ZL9pad_readsi(i32 noundef %12)
  store i32 %13, ptr %2, align 4
  store i32 0, ptr %3, align 4
  store i32 75, ptr %3, align 4
  %14 = call noundef ptr @_ZN14CommonObserverC1Ev(ptr noundef nonnull align 8 dereferenceable(8) %4) #5
  %15 = call noundef ptr @_ZN12RareObserverC1Ev(ptr noundef nonnull align 8 dereferenceable(8) %5) #5
  store ptr %4, ptr %6, align 8
  %16 = load i32, ptr @_ZZ4mainE4tick, align 4
  %17 = srem i32 %16, 29
  %18 = icmp eq i32 %17, 19
  br i1 %18, label %19, label %20

19:                                               ; preds = %0
  store ptr %5, ptr %6, align 8
  br label %20

20:                                               ; preds = %19, %0
  %21 = load ptr, ptr %6, align 8
  %22 = load ptr, ptr %21, align 8
  %23 = getelementptr inbounds ptr, ptr %22, i64 0
  %24 = load ptr, ptr %23, align 8
  %25 = invoke noundef i32 %24(ptr noundef nonnull align 8 dereferenceable(8) %21, ptr noundef %3)
          to label %26 unwind label %32

26:                                               ; preds = %20
  store i32 %25, ptr %7, align 4
  %27 = load i32, ptr @_ZZ4mainE4tick, align 4
  %28 = add nsw i32 %27, 1
  store i32 %28, ptr @_ZZ4mainE4tick, align 4
  %29 = call noundef ptr @_ZN12RareObserverD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %5) #5
  %30 = call noundef ptr @_ZN14CommonObserverD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %4) #5
  %31 = load i32, ptr %1, align 4
  ret i32 %31

32:                                               ; preds = %20
  %33 = landingpad { ptr, i32 }
          cleanup
  %34 = extractvalue { ptr, i32 } %33, 0
  store ptr %34, ptr %8, align 8
  %35 = extractvalue { ptr, i32 } %33, 1
  store i32 %35, ptr %9, align 4
  %36 = call noundef ptr @_ZN12RareObserverD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %5) #5
  %37 = call noundef ptr @_ZN14CommonObserverD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %4) #5
  br label %38

38:                                               ; preds = %32
  %39 = load ptr, ptr %8, align 8
  %40 = load i32, ptr %9, align 4
  %41 = insertvalue { ptr, i32 } poison, ptr %39, 0
  %42 = insertvalue { ptr, i32 } %41, i32 %40, 1
  resume { ptr, i32 } %42
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal noundef i32 @_ZL9pad_readsi(i32 noundef %0) #1 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  store i32 0, ptr %3, align 4
  store i32 0, ptr %4, align 4
  br label %6

6:                                                ; preds = %25, %1
  %7 = load i32, ptr %4, align 4
  %8 = load i32, ptr %2, align 4
  %9 = icmp slt i32 %7, %8
  br i1 %9, label %10, label %28

10:                                               ; preds = %6
  store i32 0, ptr %5, align 4
  br label %11

11:                                               ; preds = %21, %10
  %12 = load i32, ptr %5, align 4
  %13 = icmp slt i32 %12, 32
  br i1 %13, label %14, label %24

14:                                               ; preds = %11
  %15 = load i32, ptr %5, align 4
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds [32 x i32], ptr @_ZL7scratch, i64 0, i64 %16
  %18 = load i32, ptr %17, align 4
  %19 = load i32, ptr %3, align 4
  %20 = add nsw i32 %19, %18
  store i32 %20, ptr %3, align 4
  br label %21

21:                                               ; preds = %14
  %22 = load i32, ptr %5, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, ptr %5, align 4
  br label %11, !llvm.loop !5

24:                                               ; preds = %11
  br label %25

25:                                               ; preds = %24
  %26 = load i32, ptr %4, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, ptr %4, align 4
  br label %6, !llvm.loop !7

28:                                               ; preds = %6
  %29 = load i32, ptr %3, align 4
  ret i32 %29
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN14CommonObserverC1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN14CommonObserverC2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #5
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN12RareObserverC1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN12RareObserverC2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #5
  ret ptr %3
}

declare i32 @__gxx_personality_v0(...)

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN12RareObserverD1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN12RareObserverD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #5
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN14CommonObserverD1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN14CommonObserverD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #5
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN14CommonObserverC2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN8ObserverC2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #5
  store ptr getelementptr inbounds ({ [5 x ptr] }, ptr @_ZTV14CommonObserver, i32 0, inrange i32 0, i32 2), ptr %3, align 8
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN8ObserverC2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  store ptr getelementptr inbounds ({ [5 x ptr] }, ptr @_ZTV8Observer, i32 0, inrange i32 0, i32 2), ptr %3, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef i32 @_ZN14CommonObserver7observeEPKi(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef %1) unnamed_addr #1 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = load i32, ptr %6, align 4
  %8 = add nsw i32 %7, 1
  ret i32 %8
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr void @_ZN14CommonObserverD0Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) unnamed_addr #2 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN14CommonObserverD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #5
  call void @_ZdlPv(ptr noundef %3) #6
  ret void
}

declare void @__cxa_pure_virtual() unnamed_addr

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN8ObserverD1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 align 2 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = load ptr, ptr %3, align 8
  store ptr %4, ptr %2, align 8
  call void @llvm.trap() #7
  unreachable
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr void @_ZN8ObserverD0Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) unnamed_addr #2 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  call void @llvm.trap() #7
  unreachable
}

; Function Attrs: cold noreturn nounwind
declare void @llvm.trap() #3

; Function Attrs: nobuiltin nounwind
declare void @_ZdlPv(ptr noundef) #4

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN12RareObserverC2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN8ObserverC2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #5
  store ptr getelementptr inbounds ({ [5 x ptr] }, ptr @_ZTV12RareObserver, i32 0, inrange i32 0, i32 2), ptr %3, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef i32 @_ZN12RareObserver7observeEPKi(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef %1) unnamed_addr #1 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = load i32, ptr %6, align 4
  %8 = add nsw i32 %7, 2
  ret i32 %8
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr void @_ZN12RareObserverD0Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) unnamed_addr #2 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN12RareObserverD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #5
  call void @_ZdlPv(ptr noundef %3) #6
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN12RareObserverD2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN8ObserverD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #5
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN8ObserverD2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN14CommonObserverD2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN8ObserverD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #5
  ret ptr %3
}

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #1 = { mustprogress noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #2 = { noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #3 = { cold noreturn nounwind }
attributes #4 = { nobuiltin nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #5 = { nounwind }
attributes #6 = { builtin nounwind }
attributes #7 = { noreturn nounwind }

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
