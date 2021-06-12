#!/bin/bash

mkdir build

ret=$?
if [ $ret -ne 0 ]
then
    exit $ret
fi

cd build

ret=$?
if [ $ret -ne 0 ]
then
    exit $ret
fi

if [ "${ARCH}" == "32" ]
then
    export BIT32="ON"
    #export ARCH_FLAG="-m32"
    #ZLIB32="-DZLIB_LIBRARY=/usr/lib32/libz.a"
    #export CMAKE_LIBRARY_PATH=/usr/lib/i386-linux-gnu/cmake
else
    export BIT32="OFF"
    #export ARCH_FLAG="-m64"
fi

cmake -DCMAKE_PREFIX_PATH="$HOME/zlib-prefix;$HOME/boost-prefix" -DMSGPACK_BUILD_TESTS=ON -D${MSGPACK_CXX_VERSION} -DMSGPACK_32BIT=${BIT32} -DMSGPACK_CHAR_SIGN=${CHAR_SIGN} -DMSGPACK_DEFAULT_API_VERSION=${API_VERSION} -DMSGPACK_USE_X3_PARSE=${X3_PARSE} ..

ret=$?
if [ $ret -ne 0 ]
then
    exit $ret
fi

make

ret=$?
if [ $ret -ne 0 ]
then
    exit $ret
fi

ctest -VV

ret=$?
if [ $ret -ne 0 ]
then
    exit $ret
fi

make install DESTDIR=`pwd`/install

ret=$?
if [ $ret -ne 0 ]
then
    exit $ret
fi

if [ "${ARCH}" != "32" ] && [ `uname` = "Linux" ]
then
    ctest -T memcheck | tee memcheck.log

    ret=${PIPESTATUS[0]}
    if [ $ret -ne 0 ]
    then
        exit $ret
    fi
    cat memcheck.log | grep "Memory Leak" > /dev/null
    ret=$?
    if [ $ret -eq 0 ]
    then
        exit 1
    fi
fi

if [ "${ARCH}" != "32" ]
then
    mkdir install-test

    ret=$?
    if [ $ret -ne 0 ]
    then
        exit $ret
    fi

    cd install-test

    ret=$?
    if [ $ret -ne 0 ]
    then
        exit $ret
    fi

    ${CXX} ../../example/cpp03/simple.cpp -o simple -I `pwd`/../install/usr/local/include

    ret=$?
    if [ $ret -ne 0 ]
    then
        exit $ret
    fi

    ./simple

    ret=$?
    if [ $ret -ne 0 ]
    then
        exit $ret
    fi
fi

exit 0
