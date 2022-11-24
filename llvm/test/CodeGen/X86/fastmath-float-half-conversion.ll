; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-unknown-unknown -mattr=+f16c < %s | FileCheck %s --check-prefix=ALL --check-prefix=F16C
; RUN: llc -mtriple=x86_64-unknown-unknown -mattr=+avx < %s | FileCheck %s --check-prefix=ALL --check-prefix=AVX

define zeroext i16 @test1_fast(double %d) #0 {
; F16C-LABEL: test1_fast:
; F16C:       # %bb.0: # %entry
; F16C-NEXT:    vcvtsd2ss %xmm0, %xmm0, %xmm0
; F16C-NEXT:    vcvtps2ph $4, %xmm0, %xmm0
; F16C-NEXT:    vmovd %xmm0, %eax
; F16C-NEXT:    # kill: def $ax killed $ax killed $eax
; F16C-NEXT:    retq
;
; AVX-LABEL: test1_fast:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    pushq %rax
; AVX-NEXT:    .cfi_def_cfa_offset 16
; AVX-NEXT:    callq __truncdfhf2@PLT
; AVX-NEXT:    popq %rcx
; AVX-NEXT:    .cfi_def_cfa_offset 8
; AVX-NEXT:    retq
entry:
  %0 = tail call i16 @llvm.convert.to.fp16.f64(double %d)
  ret i16 %0
}

define zeroext i16 @test2_fast(x86_fp80 %d) #0 {
; F16C-LABEL: test2_fast:
; F16C:       # %bb.0: # %entry
; F16C-NEXT:    fldt {{[0-9]+}}(%rsp)
; F16C-NEXT:    fstps -{{[0-9]+}}(%rsp)
; F16C-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; F16C-NEXT:    vcvtps2ph $4, %xmm0, %xmm0
; F16C-NEXT:    vmovd %xmm0, %eax
; F16C-NEXT:    # kill: def $ax killed $ax killed $eax
; F16C-NEXT:    retq
;
; AVX-LABEL: test2_fast:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    subq $24, %rsp
; AVX-NEXT:    .cfi_def_cfa_offset 32
; AVX-NEXT:    fldt {{[0-9]+}}(%rsp)
; AVX-NEXT:    fstpt (%rsp)
; AVX-NEXT:    callq __truncxfhf2@PLT
; AVX-NEXT:    addq $24, %rsp
; AVX-NEXT:    .cfi_def_cfa_offset 8
; AVX-NEXT:    retq
entry:
  %0 = tail call i16 @llvm.convert.to.fp16.f80(x86_fp80 %d)
  ret i16 %0
}

define zeroext i16 @test1(double %d) #1 {
; ALL-LABEL: test1:
; ALL:       # %bb.0: # %entry
; ALL-NEXT:    pushq %rax
; ALL-NEXT:    .cfi_def_cfa_offset 16
; ALL-NEXT:    callq __truncdfhf2@PLT
; ALL-NEXT:    popq %rcx
; ALL-NEXT:    .cfi_def_cfa_offset 8
; ALL-NEXT:    retq
entry:
  %0 = tail call i16 @llvm.convert.to.fp16.f64(double %d)
  ret i16 %0
}

define zeroext i16 @test2(x86_fp80 %d) #1 {
; ALL-LABEL: test2:
; ALL:       # %bb.0: # %entry
; ALL-NEXT:    subq $24, %rsp
; ALL-NEXT:    .cfi_def_cfa_offset 32
; ALL-NEXT:    fldt {{[0-9]+}}(%rsp)
; ALL-NEXT:    fstpt (%rsp)
; ALL-NEXT:    callq __truncxfhf2@PLT
; ALL-NEXT:    addq $24, %rsp
; ALL-NEXT:    .cfi_def_cfa_offset 8
; ALL-NEXT:    retq
entry:
  %0 = tail call i16 @llvm.convert.to.fp16.f80(x86_fp80 %d)
  ret i16 %0
}

declare i16 @llvm.convert.to.fp16.f64(double)
declare i16 @llvm.convert.to.fp16.f80(x86_fp80)

attributes #0 = { nounwind readnone uwtable "unsafe-fp-math"="true" "use-soft-float"="false" }
attributes #1 = { nounwind readnone uwtable "unsafe-fp-math"="false" "use-soft-float"="false" }