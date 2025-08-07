#!/bin/bash -e

set -x

git clone https://github.com/ICLDisco/parsec
cd parsec
git apply ../parsec.patch
mkdir build
cd build

DEBUG=OFF
[ "$BUILD_TYPE" = "Debug" ] && DEBUG=ON

cmake   -L -G Ninja \
        -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
        -DPARSEC_DEBUG_NOISIER=$DEBUG \
        -DPARSEC_DEBUG_PARANOID=$DEBUG \
        -DBUILD_SHARED_LIBS=ON \
        -DPARSEC_PROF_TRACE=ON \
        -DMPIEXEC_PREFLAGS='--bind-to;none;--oversubscribe' \
        -DCMAKE_INSTALL_PREFIX=/tmp/parsec/install \
        -DPARSEC_GPU_WITH_CUDA=OFF \
        -DPARSEC_GPU_WITH_HIP=OFF \
	..
cmake --build .

export PARSEC_MCA_device_cuda_enabled=0
export PARSEC_MCA_device_hip_enabled=0
export PARSEC_MCA_device_cuda_memory_use=10
export PARSEC_MCA_device_hip_memory_use=10
ctest --output-on-failure

cmake --build . --target install

