add_mlir_conversion_library(MLIRGPUToSPIRV
  GPUToSPIRV.cpp
  GPUToSPIRVPass.cpp

  DEPENDS
  MLIRConversionPassIncGen

  LINK_LIBS PUBLIC
  MLIRGPUOps
  MLIRIR
  MLIRPass
  MLIRSCFToSPIRV
  MLIRSPIRV
  MLIRSPIRVConversion
  MLIRStandard
  MLIRStandardToSPIRV
  MLIRSupport
  MLIRTransforms
  )
