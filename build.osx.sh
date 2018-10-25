#!/usr/bin/bash


tdPath="./td/"
mkdir ${tdPath}/build
cd ${tdPath}/build
cmake -DCMAKE_BUILD_TYPE=Release -DOPENSSL_ROOT_DIR=/usr/local/opt/openssl/ -DTD_ENABLE_JNI=ON ..
cmake --build .


