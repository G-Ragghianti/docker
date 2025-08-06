#!/bin/bash -e

cmake -S ../doc/dox/dev/devsamp/helloworld -B test_install_devsamp_helloworld -DCMAKE_PREFIX_PATH=../install || (cat /home/runner/work/ttg/ttg/install/lib/cmake/ttg/ttg-config.cmake && test_install_devsamp_helloworld/CMakeFiles/CMakeConfigureLog.yaml)
cmake --build test_install_devsamp_helloworld
$MPIEXEC -n 2 test_install_devsamp_helloworld/helloworld-parsec
$MPIEXEC -n 2 test_install_devsamp_helloworld/helloworld-mad
cmake -S ../doc/dox/dev/devsamp/fibonacci -B test_install_devsamp_fibonacci -DCMAKE_PREFIX_PATH=../install || (cat /home/runner/work/ttg/ttg/install/lib/cmake/ttg/ttg-config.cmake && cat test_install_devsamp_fibonacci/CMakeFiles/CMakeConfigureLog.yaml)
cmake --build test_install_devsamp_fibonacci
$MPIEXEC -n 2 test_install_devsamp_fibonacci/fibonacci-parsec
cmake -E make_directory test_install_userexamples
cat > test_install_userexamples/CMakeLists.txt <<EOF
cmake_minimum_required(VERSION 3.14)
project(test)
find_package(ttg REQUIRED)
add_ttg_executable(simple ../doc/dox/user/examples/simple.cc NOT_EXCLUDE_FROM_ALL)
add_ttg_executable(reducing ../doc/dox/user/examples/reducing.cc NOT_EXCLUDE_FROM_ALL)
add_ttg_executable(iterative ../doc/dox/user/examples/iterative.cc NOT_EXCLUDE_FROM_ALL)
add_ttg_executable(distributed ../doc/dox/user/examples/distributed.cc NOT_EXCLUDE_FROM_ALL)
EOF
cmake -S test_install_userexamples -B test_install_userexamples/build -DCMAKE_PREFIX_PATH=../install || (cat /home/runner/work/ttg/ttg/install/lib/cmake/ttg/ttg-config.cmake && cat test_install_devsamp_fibonacci/CMakeFiles/CMakeConfigureLog.yaml)
        cmake --build test_install_userexamples/build

