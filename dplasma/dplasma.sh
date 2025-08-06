#!/bin/bash -e

git clone https://github.com/ICLDisco/dplasma
cd dplasma
rm -rf parsec
mkdir build
cd build
CC=gcc CXX=g++ FC=gfortran cmake \
	-G Ninja \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_SHARED_LIBS=ON \
        -DMPIEXEC_PREFLAGS='--bind-to;none;--oversubscribe' \
        -DCMAKE_INSTALL_PREFIX=$PWD/dplasma/install \
        -DDPLASMA_PRECISIONS=d \
        -DPARSEC_HAVE_DEV_RECURSIVE_SUPPORT=OFF \
        -DDPLASMA_GPU_WITH_CUDA=OFF \
        -DDPLASMA_GPU_WITH_HIP=OFF \
	-DPaRSEC_ROOT=/tmp/parsec/install \
	..
cmake --build .
ctest --output-on-failure
# ctest --output-on-failure -R 'launcher|dplasma' -E lowmem
# --verbose
