#!/bin/bash

mkdir -p build

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
    echo "64 bit support required for regressions"
    exit 1
fi

cmake -DMSGPACK_FUZZ_REGRESSION="ON" -D${MSGPACK_CXX_VERSION} -DMSGPACK_CHAR_SIGN=${CHAR_SIGN} -DMSGPACK_DEFAULT_API_VERSION=${API_VERSION} -DMSGPACK_USE_X3_PARSE=${X3_PARSE} -DCMAKE_CXX_FLAGS="${CXXFLAGS}" ..

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

make test

ret=$?
if [ $ret -ne 0 ]
then
    exit $ret
fi

exit 0
