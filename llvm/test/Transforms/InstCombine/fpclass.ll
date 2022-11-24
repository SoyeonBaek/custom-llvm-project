; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -instcombine < %s | FileCheck %s

define i1 @isnan_f32_noflags(float %x, float %y) {
; CHECK-LABEL: @isnan_f32_noflags(
; CHECK-NEXT:    [[R:%.*]] = fmul float [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[T:%.*]] = call i1 @llvm.isnan.f32(float [[R]])
; CHECK-NEXT:    ret i1 [[T]]
;
  %r = fmul float %x, %y
  %t = call i1 @llvm.isnan.f32(float %r)
  ret i1 %t
}


define i1 @isnan_f32_load(float* %p) {
  %r = load float, float* %p
  %t = call i1 @llvm.isnan.f32(float %r)
  ret i1 %t
}

define i1 @isnan_f32_ninf(float %x, float %y) {
; CHECK-LABEL: @isnan_f32_ninf(
; CHECK-NEXT:    [[R:%.*]] = fsub ninf float [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[T:%.*]] = call i1 @llvm.isnan.f32(float [[R]])
; CHECK-NEXT:    ret i1 [[T]]
;
  %r = fsub ninf float %x, %y
  %t = call i1 @llvm.isnan.f32(float %r)
  ret i1 %t
}

define i1 @isnan_f32_nsz(float %x, float %y) {
; CHECK-LABEL: @isnan_f32_nsz(
; CHECK-NEXT:    [[R:%.*]] = fdiv nsz float [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[T:%.*]] = call i1 @llvm.isnan.f32(float [[R]])
; CHECK-NEXT:    ret i1 [[T]]
;
  %r = fdiv nsz float %x, %y
  %t = call i1 @llvm.isnan.f32(float %r)
  ret i1 %t
}

define i1 @isnan_f32(float %x, float %y) {
; CHECK-LABEL: @isnan_f32(
; CHECK-NEXT:    ret i1 false
;
  %r = fadd nnan float %x, %y
  %t = call i1 @llvm.isnan.f32(float %r)
  ret i1 %t
}

define <1 x i1> @isnan_v1f32(<1 x float> %x, <1 x float> %y) {
; CHECK-LABEL: @isnan_v1f32(
; CHECK-NEXT:    ret <1 x i1> zeroinitializer
;
  %r = fadd nnan <1 x  float> %x, %y
  %t = call <1 x i1> @llvm.isnan.v1f32(<1 x float> %r)
  ret <1 x i1> %t
}

define <2 x i1> @isnan_v2f32(<2 x float> %x, <2 x float> %y) {
; CHECK-LABEL: @isnan_v2f32(
; CHECK-NEXT:    ret <2 x i1> zeroinitializer
;
  %r = fadd nnan <2 x  float> %x, %y
  %t = call <2 x i1> @llvm.isnan.v2f32(<2 x float> %r)
  ret <2 x i1> %t
}

declare i1 @llvm.isnan.f32(float %r)
declare <1 x i1> @llvm.isnan.v1f32(<1 x float> %r)
declare <2 x i1> @llvm.isnan.v2f32(<2 x float> %r)