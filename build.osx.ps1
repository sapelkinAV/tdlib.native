param (
    $td = "$PSScriptRoot/td"
)

$build_path = "$td/build"
$java_path = "$td/example/java"
$java_compile_destination = "$java_path/bin"

echo "build_path : $build_path"
echo "java_path  : $java_path"

$ErrorActionPreference = 'Stop'

if (-not (Test-Path $td/build)) {
    New-Item -Type Directory $td/build
}
if (-not (Test-Path $td/example/java/build)) {
    New-Item -Type Directory $td/example/java/build
}


Push-Location $build_path
try {

    $cmakeArguments = @(
        '-DCMAKE_BUILD_TYPE=Release'
        '-DOPENSSL_ROOT_DIR=/usr/local/opt/openssl/'
        "-DCMAKE_INSTALL_PREFIX:PATH=../example/java/td"
        '-DTD_ENABLE_JNI=ON'
        '..'
    )
    $cmakeBuildArguments = @(
        '--build'
        '.'
    )

    cmake $cmakeArguments
    if (!$?) {
        throw 'Cannot execute cmake'
    }

    cmake $cmakeBuildArguments
    if (!$?) {
        throw 'Cannot execute cmake --build'
    }
} finally {
    Pop-Location
}



