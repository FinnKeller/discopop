; ModuleID = '/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_071_srcvol_yes/case_071_srcvol_yes.cpp'
source_filename = "/Users/finn/__Bacherlor/discopop/volatility_benchmarks/benchmarks/automatic/case_071_srcvol_yes/case_071_srcvol_yes.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx16.0.0"

%struct.PlainReader = type { %struct.Reader }
%struct.Reader = type { ptr }
%struct.ScaledReader = type { %struct.Reader }

@_ZTV11PlainReader = linkonce_odr unnamed_addr constant { [5 x ptr] } { [5 x ptr] [ptr null, ptr @_ZTI11PlainReader, ptr @_ZN11PlainReader4loadEPKi, ptr @_ZN11PlainReaderD1Ev, ptr @_ZN11PlainReaderD0Ev] }, align 8
@_ZTVN10__cxxabiv120__si_class_type_infoE = external global ptr
@_ZTS11PlainReader = linkonce_odr hidden constant [14 x i8] c"11PlainReader\00", align 1
@_ZTVN10__cxxabiv117__class_type_infoE = external global ptr
@_ZTS6Reader = linkonce_odr hidden constant [8 x i8] c"6Reader\00", align 1
@_ZTI6Reader = linkonce_odr hidden constant { ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv117__class_type_infoE, i64 2), ptr inttoptr (i64 add (i64 ptrtoint (ptr @_ZTS6Reader to i64), i64 -9223372036854775808) to ptr) }, align 8
@_ZTI11PlainReader = linkonce_odr hidden constant { ptr, ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2), ptr inttoptr (i64 add (i64 ptrtoint (ptr @_ZTS11PlainReader to i64), i64 -9223372036854775808) to ptr), ptr @_ZTI6Reader }, align 8
@_ZTV6Reader = linkonce_odr unnamed_addr constant { [5 x ptr] } { [5 x ptr] [ptr null, ptr @_ZTI6Reader, ptr @__cxa_pure_virtual, ptr @_ZN6ReaderD1Ev, ptr @_ZN6ReaderD0Ev] }, align 8
@_ZTV12ScaledReader = linkonce_odr unnamed_addr constant { [5 x ptr] } { [5 x ptr] [ptr null, ptr @_ZTI12ScaledReader, ptr @_ZN12ScaledReader4loadEPKi, ptr @_ZN12ScaledReaderD1Ev, ptr @_ZN12ScaledReaderD0Ev] }, align 8
@_ZTS12ScaledReader = linkonce_odr hidden constant [15 x i8] c"12ScaledReader\00", align 1
@_ZTI12ScaledReader = linkonce_odr hidden constant { ptr, ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2), ptr inttoptr (i64 add (i64 ptrtoint (ptr @_ZTS12ScaledReader to i64), i64 -9223372036854775808) to ptr), ptr @_ZTI6Reader }, align 8

; Function Attrs: mustprogress noinline norecurse ssp uwtable(sync)
define noundef i32 @main() #0 personality ptr @__gxx_personality_v0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca %struct.PlainReader, align 8
  %4 = alloca %struct.ScaledReader, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %2, align 4
  store i32 71, ptr %2, align 4
  %9 = call noundef ptr @_ZN11PlainReaderC1Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  %10 = call noundef ptr @_ZN12ScaledReaderC1Ev(ptr noundef nonnull align 8 dereferenceable(8) %4) #6
  store ptr null, ptr %5, align 8
  %11 = invoke i32 @rand()
          to label %12 unwind label %16

12:                                               ; preds = %0
  %13 = srem i32 %11, 2
  %14 = icmp eq i32 %13, 0
  br i1 %14, label %15, label %22

15:                                               ; preds = %12
  store ptr %3, ptr %5, align 8
  br label %23

16:                                               ; preds = %23, %0
  %17 = landingpad { ptr, i32 }
          cleanup
  %18 = extractvalue { ptr, i32 } %17, 0
  store ptr %18, ptr %6, align 8
  %19 = extractvalue { ptr, i32 } %17, 1
  store i32 %19, ptr %7, align 4
  %20 = call noundef ptr @_ZN12ScaledReaderD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %4) #6
  %21 = call noundef ptr @_ZN11PlainReaderD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  br label %33

22:                                               ; preds = %12
  store ptr %4, ptr %5, align 8
  br label %23

23:                                               ; preds = %22, %15
  %24 = load ptr, ptr %5, align 8
  %25 = load ptr, ptr %24, align 8
  %26 = getelementptr inbounds ptr, ptr %25, i64 0
  %27 = load ptr, ptr %26, align 8
  %28 = invoke noundef i32 %27(ptr noundef nonnull align 8 dereferenceable(8) %24, ptr noundef %2)
          to label %29 unwind label %16

29:                                               ; preds = %23
  store i32 %28, ptr %8, align 4
  %30 = call noundef ptr @_ZN12ScaledReaderD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %4) #6
  %31 = call noundef ptr @_ZN11PlainReaderD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  %32 = load i32, ptr %1, align 4
  ret i32 %32

33:                                               ; preds = %16
  %34 = load ptr, ptr %6, align 8
  %35 = load i32, ptr %7, align 4
  %36 = insertvalue { ptr, i32 } poison, ptr %34, 0
  %37 = insertvalue { ptr, i32 } %36, i32 %35, 1
  resume { ptr, i32 } %37
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN11PlainReaderC1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN11PlainReaderC2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN12ScaledReaderC1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN12ScaledReaderC2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

declare i32 @rand() #2

declare i32 @__gxx_personality_v0(...)

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN12ScaledReaderD1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN12ScaledReaderD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN11PlainReaderD1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN11PlainReaderD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN11PlainReaderC2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN6ReaderC2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  store ptr getelementptr inbounds ({ [5 x ptr] }, ptr @_ZTV11PlainReader, i32 0, inrange i32 0, i32 2), ptr %3, align 8
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN6ReaderC2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  store ptr getelementptr inbounds ({ [5 x ptr] }, ptr @_ZTV6Reader, i32 0, inrange i32 0, i32 2), ptr %3, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef i32 @_ZN11PlainReader4loadEPKi(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef %1) unnamed_addr #3 align 2 {
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
define linkonce_odr void @_ZN11PlainReaderD0Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN11PlainReaderD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  call void @_ZdlPv(ptr noundef %3) #7
  ret void
}

declare void @__cxa_pure_virtual() unnamed_addr

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN6ReaderD1Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = load ptr, ptr %3, align 8
  store ptr %4, ptr %2, align 8
  call void @llvm.trap() #8
  unreachable
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr void @_ZN6ReaderD0Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
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
define linkonce_odr noundef ptr @_ZN12ScaledReaderC2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN6ReaderC2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  store ptr getelementptr inbounds ({ [5 x ptr] }, ptr @_ZTV12ScaledReader, i32 0, inrange i32 0, i32 2), ptr %3, align 8
  ret ptr %3
}

; Function Attrs: mustprogress noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef i32 @_ZN12ScaledReader4loadEPKi(ptr noundef nonnull align 8 dereferenceable(8) %0, ptr noundef %1) unnamed_addr #3 align 2 {
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
define linkonce_odr void @_ZN12ScaledReaderD0Ev(ptr noundef nonnull align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN12ScaledReaderD1Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  call void @_ZdlPv(ptr noundef %3) #7
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN12ScaledReaderD2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN6ReaderD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN6ReaderD2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  ret ptr %3
}

; Function Attrs: noinline nounwind ssp uwtable(sync)
define linkonce_odr noundef ptr @_ZN11PlainReaderD2Ev(ptr noundef nonnull returned align 8 dereferenceable(8) %0) unnamed_addr #1 align 2 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef ptr @_ZN6ReaderD2Ev(ptr noundef nonnull align 8 dereferenceable(8) %3) #6
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
