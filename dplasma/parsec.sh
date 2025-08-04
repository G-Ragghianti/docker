#!/bin/bash -e

git clone https://github.com/ICLDisco/parsec
cd parsec
git apply ../parsec.patch
mkdir build
cd build

cmake   -G Ninja \
        -DCMAKE_BUILD_TYPE=Release \
        -DPARSEC_DEBUG_NOISIER=OFF \
        -DPARSEC_DEBUG_PARANOID=OFF \
        -DBUILD_SHARED_LIBS=ON \
        -DPARSEC_PROF_TRACE=ON \
        -DMPIEXEC_PREFLAGS='--bind-to;none;--oversubscribe' \
        -DCMAKE_INSTALL_PREFIX=/tmp/parsec \
        -DPARSEC_GPU_WITH_CUDA=OFF \
        -DPARSEC_GPU_WITH_HIP=OFF \
	..
cmake --build .
cmake --build . --target install
export PARSEC_MCA_device_cuda_enabled=0
export PARSEC_MCA_device_hip_enabled=0
export PARSEC_MCA_device_cuda_memory_use=10
export PARSEC_MCA_device_hip_memory_use=10
ctest --output-on-failure

