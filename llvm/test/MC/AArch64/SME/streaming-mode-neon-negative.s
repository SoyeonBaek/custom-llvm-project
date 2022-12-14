// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+streaming-sve 2>&1 < %s| FileCheck %s

// ------------------------------------------------------------------------- //
// Check FABD is illegal in streaming mode

fabd s0, s1, s2
// CHECK: [[@LINE-1]]:{{[0-9]+}}: error: instruction requires: neon
// CHECK-NEXT: fabd s0, s1, s2
// CHECK-NOT: [[@LINE-1]]:{{[0-9]+}}:
