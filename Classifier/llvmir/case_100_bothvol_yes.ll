; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_100_bothvol_yes/case_100_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_100_bothvol_yes/case_100_bothvol_yes.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct.CommonSink = type { %struct.Sink }
%struct.Sink = type { ptr }
%struct.RareSink = type { %struct.Sink }
%struct.CommonSource = type { %struct.Source }
%struct.Source = type { ptr }
%struct.RareSource = type { %struct.Source }

@_ZZ4mainE4tick = internal global i32 0, align 4
@_ZTV10CommonSink = linkonce_odr unnamed_addr constant { [5 x ptr] } { [5 x ptr] [ptr null, ptr @_ZTI10CommonSink, ptr @_ZN10CommonSink5storeEPi, ptr @_ZN10CommonSinkD1Ev, ptr @_ZN10CommonSinkD0Ev] }, align 8
@_ZTI10CommonSink = linkonce_odr hidden constant { ptr, ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2), ptr inttoptr (i64 add (i64 ptrtoint (ptr @_ZTS10CommonSink to i64), i64 -9223372036854775808) to ptr), ptr @_ZTI4Sink }, align 8
@_ZTVN10__cxxabiv120__si_class_type_infoE = external global [0 x ptr]
@_ZTS10CommonSink = linkonce_odr hidden constant [13 x i8] c"10CommonSink\00", align 1
@_ZTI4Sink = linkonce_odr hidden constant { ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv117__class_type_infoE, i64 2), ptr inttoptr (i64 add (i64 ptrtoint (ptr @_ZTS4Sink to i64), i64 -9223372036854775808) to ptr) }, align 8
@_ZTVN10__cxxabiv117__class_type_infoE = external global [0 x ptr]
@_ZTS4Sink = linkonce_odr hidden constant [6 x i8] c"4Sink\00", align 1
@_ZTV4Sink = linkonce_odr unnamed_addr constant { [5 x ptr] } { [5 x ptr] [ptr null, ptr @_ZTI4Sink, ptr @__cxa_pure_virtual, ptr @_ZN4SinkD1Ev, ptr @_ZN4SinkD0Ev] }, align 8
@_ZTV8RareSink = linkonce_odr unnamed_addr constant { [5 x ptr] } { [5 x ptr] [ptr null, ptr @_ZTI8RareSink, ptr @_ZN8RareSink5storeEPi, ptr @_ZN8RareSinkD1Ev, ptr @_ZN8RareSinkD0Ev] }, align 8
@_ZTI8RareSink = linkonce_odr hidden constant { ptr, ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2), ptr inttoptr (i64 add (i64 ptrtoint (ptr @_ZTS8RareSink to i64), i64 -9223372036854775808) to ptr), ptr @_ZTI4Sink }, align 8
@_ZTS8RareSink = linkonce_odr hidden constant [10 x i8] c"8RareSink\00", align 1
@_ZTV12CommonSource = linkonce_odr unnamed_addr constant { [5 x ptr] } { [5 x ptr] [ptr null, ptr @_ZTI12CommonSource, ptr @_ZN12CommonSource4loadEPKi, ptr @_ZN12CommonSourceD1Ev, ptr @_ZN12CommonSourceD0Ev] }, align 8
@_ZTI12CommonSource = linkonce_odr hidden constant { ptr, ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2), ptr inttoptr (i64 add (i64 ptrtoint (ptr @_ZTS12CommonSource to i64), i64 -9223372036854775808) to ptr), ptr @_ZTI6Source }, align 8
@_ZTS12CommonSource = linkonce_odr hidden constant [15 x i8] c"12CommonSource\00", align 1
@_ZTI6Source = linkonce_odr hidden constant { ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv117__class_type_infoE, i64 2), ptr inttoptr (i64 add (i64 ptrtoint (ptr @_ZTS6Source to i64), i64 -9223372036854775808) to ptr) }, align 8
@_ZTS6Source = linkonce_odr hidden constant [8 x i8] c"6Source\00", align 1
@_ZTV6Source = linkonce_odr unnamed_addr constant { [5 x ptr] } { [5 x ptr] [ptr null, ptr @_ZTI6Source, ptr @__cxa_pure_virtual, ptr @_ZN6SourceD1Ev, ptr @_ZN6SourceD0Ev] }, align 8
@_ZTV10RareSource = linkonce_odr unnamed_addr constant { [5 x ptr] } { [5 x ptr] [ptr null, ptr @_ZTI10RareSource, ptr @_ZN10RareSource4loadEPKi, ptr @_ZN10RareSourceD1Ev, ptr @_ZN10RareSourceD0Ev] }, align 8
@_ZTI10RareSource = linkonce_odr hidden constant { ptr, ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2), ptr inttoptr (i64 add (i64 ptrtoint (ptr @_ZTS10RareSource to i64), i64 -9223372036854775808) to ptr), ptr @_ZTI6Source }, align 8
@_ZTS10RareSource = linkonce_odr hidden constant [13 x i8] c"10RareSource\00", align 1
@_ZL7scratch = internal global [64 x i32] zeroinitializer, align 4

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 personality ptr @__gxx_personality_v0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca %struct.CommonSink, align 8
  %4 = alloca %struct.RareSink, align 8
  %5 = alloca %struct.CommonSource, align 8
  %6 = alloca %struct.RareSource, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %12 = call noalias noundef nonnull ptr @_Znwm(i64 noundef 4) #5
  store i32 0, ptr %12, align 4
  store ptr %12, ptr %2, align 8
  %13 = call noundef ptr @_ZN10CommonSinkC1Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  %14 = call noundef ptr @_ZN8RareSinkC1Ev(ptr noundef nonnull align 8 dereferenceable(8) %4) #6
  %15 = call noundef ptr @_ZN12CommonSourceC1Ev(ptr noundef nonnull align 8 dereferenceable(8) %5) #6
  %16 = call noundef ptr @_ZN10RareSourceC1Ev(ptr noundef nonnull align 8 dereferenceable(8) %6) #6
  store ptr %3, ptr %7, align 8
  %17 = load i32, ptr @_ZZ4mainE4tick, align 4
  %18 = srem i32 %17, 19
  %19 = icmp eq i32 %18, 5
  br i1 %19, label %20, label %21

20:                                               ; preds = %0
  store ptr %4, ptr %7, align 8
  br label %21

21:                                               ; preds = %20, %0
  store ptr %5, ptr %8, align 8
  %22 = load i32, ptr @_ZZ4mainE4tick, align 4
  %23 = srem i32 %22, 23
  %24 = icmp eq i32 %23, 11
  br i1 %24, label %25, label %26

25:                                               ; preds = %21
  store ptr %6, ptr %8, align 8
  br label %26

26:                                               ; preds = %25, %21
  %27 = load ptr, ptr %7, align 8
  %28 = load ptr, ptr %2, align 8
  %29 = load ptr, ptr %27, align 8
  %30 = getelementptr inbounds ptr, ptr %29, i64 0
  %31 = load ptr, ptr %30, align 8
  invoke void %31(ptr noundef nonnull align 8 dereferenceable(8) %27, ptr noundef %28)
          to label %32 unwind label %52

32:                                               ; preds = %26
  invoke void @_ZL10pad_writesi(i32 noundef 40)
          to label %33 unwind label %52

33:                                               ; preds = %32
  %34 = load ptr, ptr %8, align 8
  %35 = load ptr, ptr %2, align 8
  %36 = load ptr, ptr %34, align 8
  %37 = getelementptr inbounds ptr, ptr %36, i64 0
  %38 = load ptr, ptr %37, align 8
  %39 = invoke noundef i32 %38(ptr noundef nonnull align 8 dereferenceable(8) %34, ptr noundef %35)
          to label %40 unwind label %52

40:                                               ; preds = %33
  store i32 %39, ptr %11, align 4
  %41 = load ptr, ptr %2, align 8
  %42 = icmp eq ptr %41, null
  br i1 %42, label %44, label %43

43:                                               ; preds = %40
  call void @_ZdlPvm(ptr noundef %41, i64 noundef 4) #7
  br label %44

44:                                               ; preds = %43, %40
  %45 = load i32, ptr @_ZZ4mainE4tick, align 4
  %46 = add nsw i32 %45, 1
  store i32 %46, ptr @_ZZ4mainE4tick, align 4
  %47 = call noundef ptr @_ZN10RareSourceD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %6) #6
  %48 = call noundef ptr @_ZN12CommonSourceD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %5) #6
  %49 = call noundef ptr @_ZN8RareSinkD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %4) #6
  %50 = call noundef ptr @_ZN10CommonSinkD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  %51 = load i32, ptr %1, align 4
  ret i32 %51

52:                                               ; preds = %33, %32, %26
  %53 = landingpad { ptr, i32 }
          cleanup
  %54 = extractvalue { ptr, i32 } %53, 0
  store ptr %54, ptr %9, align 8
  %55 = extractvalue { ptr, i32 } %53, 1
  store i32 %55, ptr %10, align 4
  %56 = call noundef ptr @_ZN10RareSourceD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %6) #6
  %57 = call noundef ptr @_ZN12CommonSourceD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %5) #6
  %58 = call noundef ptr @_ZN8RareSinkD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %4) #6
  %59 = call noundef ptr @_ZN10CommonSinkD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  br label %60

60:                                               ; preds = %52
  %61 = load ptr, ptr %9, align 8
  %62 = load i32, ptr %10, align 4
  %63 = insertvalue { ptr, i32 } poison, ptr %61, 0
  %64 = insertvalue { ptr, i32 } %63, i32 %62, 1
  resume { ptr, i32 } %64
}

; Function Attrs: nobuiltin allocsize(0)
declare noundef nonnull ptr @_Znwm(i64 noundef) #1

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN10CommonSinkC1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN10CommonSinkC2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN8RareSinkC1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN8RareSinkC2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN12CommonSourceC1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN12CommonSourceC2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN10RareSourceC1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN10RareSourceC2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

declare i32 @__gxx_personality_v0(...)

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define internal void @_ZL10pad_writesi(i32 noundef %0) #2 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  store i32 0, ptr %3, align 4
  br label %5

5:                                                ; preds = %24, %1
  %6 = load i32, ptr %3, align 4
  %7 = load i32, ptr %2, align 4
  %8 = icmp slt i32 %6, %7
  br i1 %8, label %9, label %27

9:                                                ; preds = %5
  store i32 0, ptr %4, align 4
  br label %10

10:                                               ; preds = %20, %9
  %11 = load i32, ptr %4, align 4
  %12 = icmp slt i32 %11, 64
  br i1 %12, label %13, label %23

13:                                               ; preds = %10
  %14 = load i32, ptr %3, align 4
  %15 = load i32, ptr %4, align 4
  %16 = xor i32 %14, %15
  %17 = load i32, ptr %4, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds [64 x i32], ptr @_ZL7scratch, i64 0, i64 %18
  store i32 %16, ptr %19, align 4
  br label %20

20:                                               ; preds = %13
  %21 = load i32, ptr %4, align 4
  %22 = add nsw i32 %21, 1
  store i32 %22, ptr %4, align 4
  br label %10, !llvm.loop !6

23:                                               ; preds = %10
  br label %24

24:                                               ; preds = %23
  %25 = load i32, ptr %3, align 4
  %26 = add nsw i32 %25, 1
  store i32 %26, ptr %3, align 4
  br label %5, !llvm.loop !8

27:                                               ; preds = %5
  ret void
}

; Function Attrs: nobuiltin nounwind
declare void @_ZdlPvm(ptr noundef, i64 noundef) #3

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN10RareSourceD1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN10RareSourceD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN12CommonSourceD1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN12CommonSourceD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN8RareSinkD1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN8RareSinkD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN10CommonSinkD1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN10CommonSinkD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN10CommonSinkC2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN4SinkC2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  store ptr getelementptr inbounds inrange(-16, 24) ({ [5 x ptr] }, ptr @_ZTV10CommonSink, i32 0, i32 0, i32 2), ptr %3, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN4SinkC2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  store ptr getelementptr inbounds inrange(-16, 24) ({ [5 x ptr] }, ptr @_ZTV4Sink, i32 0, i32 0, i32 2), ptr %3, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr void @_ZN10CommonSink5storeEPi(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef %1) unnamed_addr #2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  store i32 1, ptr %6, align 4
  ret void
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr void @_ZN10CommonSinkD0Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN10CommonSinkD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  call void @_ZdlPvm(ptr noundef %3, i64 noundef 8) #7
  ret void
}

declare void @__cxa_pure_virtual() unnamed_addr

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN4SinkD1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = load ptr, ptr %3, align 8
  store ptr %4, ptr %2, align 8
  call void @llvm.trap() #8
  unreachable
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr void @_ZN4SinkD0Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  call void @llvm.trap() #8
  unreachable
}

; Function Attrs: cold noreturn nounwind memory(inaccessiblemem: write)
declare void @llvm.trap() #4

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN8RareSinkC2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN4SinkC2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  store ptr getelementptr inbounds inrange(-16, 24) ({ [5 x ptr] }, ptr @_ZTV8RareSink, i32 0, i32 0, i32 2), ptr %3, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr void @_ZN8RareSink5storeEPi(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef %1) unnamed_addr #2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  store i32 2, ptr %6, align 4
  ret void
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr void @_ZN8RareSinkD0Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN8RareSinkD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  call void @_ZdlPvm(ptr noundef %3, i64 noundef 8) #7
  ret void
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN12CommonSourceC2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN6SourceC2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  store ptr getelementptr inbounds inrange(-16, 24) ({ [5 x ptr] }, ptr @_ZTV12CommonSource, i32 0, i32 0, i32 2), ptr %3, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN6SourceC2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  store ptr getelementptr inbounds inrange(-16, 24) ({ [5 x ptr] }, ptr @_ZTV6Source, i32 0, i32 0, i32 2), ptr %3, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef i32 @_ZN12CommonSource4loadEPKi(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef %1) unnamed_addr #2 {
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

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr void @_ZN12CommonSourceD0Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN12CommonSourceD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  call void @_ZdlPvm(ptr noundef %3, i64 noundef 8) #7
  ret void
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN6SourceD1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = load ptr, ptr %3, align 8
  store ptr %4, ptr %2, align 8
  call void @llvm.trap() #8
  unreachable
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr void @_ZN6SourceD0Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  call void @llvm.trap() #8
  unreachable
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN10RareSourceC2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN6SourceC2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  store ptr getelementptr inbounds inrange(-16, 24) ({ [5 x ptr] }, ptr @_ZTV10RareSource, i32 0, i32 0, i32 2), ptr %3, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef i32 @_ZN10RareSource4loadEPKi(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef %1) unnamed_addr #2 {
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

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr void @_ZN10RareSourceD0Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN10RareSourceD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  call void @_ZdlPvm(ptr noundef %3, i64 noundef 8) #7
  ret void
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN10RareSourceD2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN6SourceD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN6SourceD2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN12CommonSourceD2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN6SourceD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN8RareSinkD2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN4SinkD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN4SinkD2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN10CommonSinkD2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN4SinkD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { nobuiltin allocsize(0) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { mustprogress noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { nobuiltin nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #4 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #5 = { builtin allocsize(0) }
attributes #6 = { nounwind }
attributes #7 = { builtin nounwind }
attributes #8 = { noreturn nounwind }

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
