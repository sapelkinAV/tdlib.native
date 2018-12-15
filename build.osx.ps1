param (
    $td = "$PSScriptRoot/td"
)

$build_path = "$td/build"
$java_path = "$td/example/java"

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
        '-DTD_ENABLE_JNI=ON'
        "-DCMAKE_INSTALL_PREFIX:PATH=$java_path/td"
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


