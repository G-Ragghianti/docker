FROM ubuntu:jammy

RUN apt-get update && \
    apt-get -y install build-essential lsb software-properties-common ninja-build g++-12 liblapack-dev \
                       libeigen3-dev openmpi-bin libopenmpi-dev libtbb-dev flex bison git wget
#RUN apt-get -y install libopenblas-dev

RUN cd /tmp/ && \
    wget -q -O - https://github.com/Kitware/CMake/releases/download/v4.1.0-rc4/cmake-4.1.0-rc4-linux-x86_64.tar.gz | tar -zx && \
    mv /tmp/cmake* /tmp/cmake

ENV PATH=/usr/sbin:/usr/bin:/tmp/cmake/bin

USER nobody

RUN git clone https://github.com/TESSEorg/ttg /tmp/ttg && \
    mkdir /tmp/ttg/build

WORKDIR /tmp/ttg/build

RUN CXX=g++-12 cmake -L .. \
        -G Ninja \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_SHARED_LIBS=OFF \
        -DMPIEXEC_PREFLAGS='--bind-to;none;--allow-run-as-root' \
        -DCMAKE_INSTALL_PREFIX=install \
        -DTTG_EXAMPLES=ON

RUN cmake --build .

RUN ctest -V -R ttg/test/core-unittests-ttg-parsec/run-np-2 ; exit 1

#RUN cmake --build . --target check-ttg

#RUN cmake --build . --target install

#COPY test_install.sh /tmp/
#RUN /tmp/test_install.sh

