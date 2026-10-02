; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_096_bothvol_yes/case_096_bothvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_096_bothvol_yes/case_096_bothvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

%struct.StorerLow = type { %struct.Storer }
%struct.Storer = type { ptr }
%struct.StorerHigh = type { %struct.Storer }
%struct.LoaderPlain = type { %struct.Loader }
%struct.Loader = type { ptr }
%struct.LoaderScaled = type { %struct.Loader }

@_ZTV9StorerLow = linkonce_odr unnamed_addr constant { [5 x ptr] } { [5 x ptr] [ptr null, ptr @_ZTI9StorerLow, ptr @_ZN9StorerLow5storeEPi, ptr @_ZN9StorerLowD1Ev, ptr @_ZN9StorerLowD0Ev] }, align 8
@_ZTVN10__cxxabiv120__si_class_type_infoE = external global ptr
@_ZTS9StorerLow = linkonce_odr hidden constant [11 x i8] c"9StorerLow\00", align 1
@_ZTVN10__cxxabiv117__class_type_infoE = external global ptr
@_ZTS6Storer = linkonce_odr hidden constant [8 x i8] c"6Storer\00", align 1
@_ZTI6Storer = linkonce_odr hidden constant { ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv117__class_type_infoE, i64 2), ptr inttoptr (i64 add (i64 ptrtoint (ptr @_ZTS6Storer to i64), i64 -9223372036854775808) to ptr) }, align 8
@_ZTI9StorerLow = linkonce_odr hidden constant { ptr, ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2), ptr inttoptr (i64 add (i64 ptrtoint (ptr @_ZTS9StorerLow to i64), i64 -9223372036854775808) to ptr), ptr @_ZTI6Storer }, align 8
@_ZTV6Storer = linkonce_odr unnamed_addr constant { [5 x ptr] } { [5 x ptr] [ptr null, ptr @_ZTI6Storer, ptr @__cxa_pure_virtual, ptr @_ZN6StorerD1Ev, ptr @_ZN6StorerD0Ev] }, align 8
@_ZTV10StorerHigh = linkonce_odr unnamed_addr constant { [5 x ptr] } { [5 x ptr] [ptr null, ptr @_ZTI10StorerHigh, ptr @_ZN10StorerHigh5storeEPi, ptr @_ZN10StorerHighD1Ev, ptr @_ZN10StorerHighD0Ev] }, align 8
@_ZTS10StorerHigh = linkonce_odr hidden constant [13 x i8] c"10StorerHigh\00", align 1
@_ZTI10StorerHigh = linkonce_odr hidden constant { ptr, ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2), ptr inttoptr (i64 add (i64 ptrtoint (ptr @_ZTS10StorerHigh to i64), i64 -9223372036854775808) to ptr), ptr @_ZTI6Storer }, align 8
@_ZTV11LoaderPlain = linkonce_odr unnamed_addr constant { [5 x ptr] } { [5 x ptr] [ptr null, ptr @_ZTI11LoaderPlain, ptr @_ZN11LoaderPlain4loadEPKi, ptr @_ZN11LoaderPlainD1Ev, ptr @_ZN11LoaderPlainD0Ev] }, align 8
@_ZTS11LoaderPlain = linkonce_odr hidden constant [14 x i8] c"11LoaderPlain\00", align 1
@_ZTS6Loader = linkonce_odr hidden constant [8 x i8] c"6Loader\00", align 1
@_ZTI6Loader = linkonce_odr hidden constant { ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv117__class_type_infoE, i64 2), ptr inttoptr (i64 add (i64 ptrtoint (ptr @_ZTS6Loader to i64), i64 -9223372036854775808) to ptr) }, align 8
@_ZTI11LoaderPlain = linkonce_odr hidden constant { ptr, ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2), ptr inttoptr (i64 add (i64 ptrtoint (ptr @_ZTS11LoaderPlain to i64), i64 -9223372036854775808) to ptr), ptr @_ZTI6Loader }, align 8
@_ZTV6Loader = linkonce_odr unnamed_addr constant { [5 x ptr] } { [5 x ptr] [ptr null, ptr @_ZTI6Loader, ptr @__cxa_pure_virtual, ptr @_ZN6LoaderD1Ev, ptr @_ZN6LoaderD0Ev] }, align 8
@_ZTV12LoaderScaled = linkonce_odr unnamed_addr constant { [5 x ptr] } { [5 x ptr] [ptr null, ptr @_ZTI12LoaderScaled, ptr @_ZN12LoaderScaled4loadEPKi, ptr @_ZN12LoaderScaledD1Ev, ptr @_ZN12LoaderScaledD0Ev] }, align 8
@_ZTS12LoaderScaled = linkonce_odr hidden constant [15 x i8] c"12LoaderScaled\00", align 1
@_ZTI12LoaderScaled = linkonce_odr hidden constant { ptr, ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2), ptr inttoptr (i64 add (i64 ptrtoint (ptr @_ZTS12LoaderScaled to i64), i64 -9223372036854775808) to ptr), ptr @_ZTI6Loader }, align 8

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 personality ptr @__gxx_personality_v0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca %struct.StorerLow, align 8
  %4 = alloca %struct.StorerHigh, align 8
  %5 = alloca %struct.LoaderPlain, align 8
  %6 = alloca %struct.LoaderScaled, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca ptr, align 8
  %11 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %2, align 4
  %12 = call noundef ptr @_ZN9StorerLowC1Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  %13 = call noundef ptr @_ZN10StorerHighC1Ev(ptr noundef nonnull align 8 dereferenceable(8) %4) #6
  %14 = call noundef ptr @_ZN11LoaderPlainC1Ev(ptr noundef nonnull align 8 dereferenceable(8) %5) #6
  %15 = call noundef ptr @_ZN12LoaderScaledC1Ev(ptr noundef nonnull align 8 dereferenceable(8) %6) #6
  %16 = invoke i32 @rand()
          to label %17 unwind label %48

17:                                               ; preds = %0
  %18 = srem i32 %16, 2
  %19 = icmp eq i32 %18, 0
  br i1 %19, label %20, label %21

20:                                               ; preds = %17
  br label %22

21:                                               ; preds = %17
  br label %22

22:                                               ; preds = %21, %20
  %23 = phi ptr [ %3, %20 ], [ %4, %21 ]
  store ptr %23, ptr %7, align 8
  %24 = invoke i32 @rand()
          to label %25 unwind label %48

25:                                               ; preds = %22
  %26 = srem i32 %24, 2
  %27 = icmp eq i32 %26, 0
  br i1 %27, label %28, label %29

28:                                               ; preds = %25
  br label %30

29:                                               ; preds = %25
  br label %30

30:                                               ; preds = %29, %28
  %31 = phi ptr [ %5, %28 ], [ %6, %29 ]
  store ptr %31, ptr %10, align 8
  %32 = load ptr, ptr %7, align 8
  %33 = load ptr, ptr %32, align 8
  %34 = getelementptr inbounds ptr, ptr %33, i64 0
  %35 = load ptr, ptr %34, align 8
  invoke void %35(ptr noundef nonnull align 8 dereferenceable(8) %32, ptr noundef %2)
          to label %36 unwind label %48

36:                                               ; preds = %30
  %37 = load ptr, ptr %10, align 8
  %38 = load ptr, ptr %37, align 8
  %39 = getelementptr inbounds ptr, ptr %38, i64 0
  %40 = load ptr, ptr %39, align 8
  %41 = invoke noundef i32 %40(ptr noundef nonnull align 8 dereferenceable(8) %37, ptr noundef %2)
          to label %42 unwind label %48

42:                                               ; preds = %36
  store i32 %41, ptr %11, align 4
  %43 = call noundef ptr @_ZN12LoaderScaledD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %6) #6
  %44 = call noundef ptr @_ZN11LoaderPlainD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %5) #6
  %45 = call noundef ptr @_ZN10StorerHighD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %4) #6
  %46 = call noundef ptr @_ZN9StorerLowD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  %47 = load i32, ptr %1, align 4
  ret i32 %47

48:                                               ; preds = %36, %30, %22, %0
  %49 = landingpad { ptr, i32 }
          cleanup
  %50 = extractvalue { ptr, i32 } %49, 0
  store ptr %50, ptr %8, align 8
  %51 = extractvalue { ptr, i32 } %49, 1
  store i32 %51, ptr %9, align 4
  %52 = call noundef ptr @_ZN12LoaderScaledD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %6) #6
  %53 = call noundef ptr @_ZN11LoaderPlainD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %5) #6
  %54 = call noundef ptr @_ZN10StorerHighD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %4) #6
  %55 = call noundef ptr @_ZN9StorerLowD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  br label %56

56:                                               ; preds = %48
  %57 = load ptr, ptr %8, align 8
  %58 = load i32, ptr %9, align 4
  %59 = insertvalue { ptr, i32 } poison, ptr %57, 0
  %60 = insertvalue { ptr, i32 } %59, i32 %58, 1
  resume { ptr, i32 } %60
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN9StorerLowC1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN9StorerLowC2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN10StorerHighC1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN10StorerHighC2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN11LoaderPlainC1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN11LoaderPlainC2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN12LoaderScaledC1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN12LoaderScaledC2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

declare i32 @rand() #2

declare i32 @__gxx_personality_v0(...)

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN12LoaderScaledD1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN12LoaderScaledD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN11LoaderPlainD1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN11LoaderPlainD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN10StorerHighD1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN10StorerHighD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN9StorerLowD1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN9StorerLowD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN9StorerLowC2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN6StorerC2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  store ptr getelementptr inbounds ({ [5 x ptr] }, ptr @_ZTV9StorerLow, i32 0, inrange i32 0, i32 2), ptr %3, align 8
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN6StorerC2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  store ptr getelementptr inbounds ({ [5 x ptr] }, ptr @_ZTV6Storer, i32 0, inrange i32 0, i32 2), ptr %3, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr void @_ZN9StorerLow5storeEPi(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef %1) unnamed_addr #3 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  store i32 1, ptr %6, align 4
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr void @_ZN9StorerLowD0Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN9StorerLowD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  call void @_ZdlPv(ptr noundef %3) #7
  ret void
}

declare void @__cxa_pure_virtual() unnamed_addr

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN6StorerD1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = load ptr, ptr %3, align 8
  store ptr %4, ptr %2, align 8
  call void @llvm.trap() #8
  unreachable
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr void @_ZN6StorerD0Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  call void @llvm.trap() #8
  unreachable
}

; Function Attrs: cold noreturn nounwind
declare void @llvm.trap() #4

; Function Attrs: nobuiltin nounwind
declare void @_ZdlPv(ptr noundef) #5

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN10StorerHighC2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN6StorerC2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  store ptr getelementptr inbounds ({ [5 x ptr] }, ptr @_ZTV10StorerHigh, i32 0, inrange i32 0, i32 2), ptr %3, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr void @_ZN10StorerHigh5storeEPi(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef %1) unnamed_addr #3 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  store i32 2, ptr %6, align 4
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr void @_ZN10StorerHighD0Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN10StorerHighD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  call void @_ZdlPv(ptr noundef %3) #7
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN11LoaderPlainC2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN6LoaderC2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  store ptr getelementptr inbounds ({ [5 x ptr] }, ptr @_ZTV11LoaderPlain, i32 0, inrange i32 0, i32 2), ptr %3, align 8
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN6LoaderC2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  store ptr getelementptr inbounds ({ [5 x ptr] }, ptr @_ZTV6Loader, i32 0, inrange i32 0, i32 2), ptr %3, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef i32 @_ZN11LoaderPlain4loadEPKi(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef %1) unnamed_addr #3 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = load i32, ptr %6, align 4
  ret i32 %7
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr void @_ZN11LoaderPlainD0Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN11LoaderPlainD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  call void @_ZdlPv(ptr noundef %3) #7
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN6LoaderD1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = load ptr, ptr %3, align 8
  store ptr %4, ptr %2, align 8
  call void @llvm.trap() #8
  unreachable
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr void @_ZN6LoaderD0Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  call void @llvm.trap() #8
  unreachable
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN12LoaderScaledC2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN6LoaderC2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  store ptr getelementptr inbounds ({ [5 x ptr] }, ptr @_ZTV12LoaderScaled, i32 0, inrange i32 0, i32 2), ptr %3, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef i32 @_ZN12LoaderScaled4loadEPKi(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef %1) unnamed_addr #3 align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = load i32, ptr %6, align 4
  %8 = mul nsw i32 %7, 3
  ret i32 %8
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr void @_ZN12LoaderScaledD0Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN12LoaderScaledD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  call void @_ZdlPv(ptr noundef %3) #7
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN12LoaderScaledD2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN6LoaderD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN6LoaderD2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN11LoaderPlainD2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN6LoaderD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN10StorerHighD2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN6StorerD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN6StorerD2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN9StorerLowD2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN6StorerD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

attributes #0 = { mustprogress noinline norecurse ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #1 = { noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #2 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #3 = { mustprogress noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #4 = { cold noreturn nounwind }
attributes #5 = { nobuiltin nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #6 = { nounwind }
attributes #7 = { builtin nounwind }
attributes #8 = { noreturn nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 16.0.6"}
