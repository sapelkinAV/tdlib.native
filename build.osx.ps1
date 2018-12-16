param (
    $td = "$PSScriptRoot/td"
)


mkdir -p ./build
mkdir -p ./example/java/build


cd ./build
cmake -DCMAKE_BUILD_TYPE=Release -DTD_ENABLE_JNI=ON -DOPENSSL_ROOT_DIR=/usr/local/opt/openssl/ -DCMAKE_INSTALL_PREFIX:PATH=../example/java/td ..
cmake --build . --target install


cd ../example/java/build
pwd
ls -al ../td/lib/cmake/Td/
cmake -DCMAKE_BUILD_TYPE=Release -DTd_DIR=././td/lib/cmake/Td/ -DCMAKE_INSTALL_PREFIX:PATH=.. ..
cmake --build . --target install
