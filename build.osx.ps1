param (
    $td = "$PSScriptRoot/td"
)

$build_path = "$td/build"
$java_path = "$td/example/java"

echo "build_path : $build_path"
echo "java_path  : $java_path"

$ErrorActionPreference = 'Stop'

if (-not (Test-Path $td/build)) {
    New-Item -Type Directory $td/build
}
if (-not (Test-Path $td/example/java/build)) {
    New-Item -Type Directory $td/example/java/build
}

if (-not (Test-Path $java_path/td)) {
    New-Item -Type Directory $java_path/td
}

Push-Location $build_path
try {

    $cmakeArguments = @(
        '-DCMAKE_BUILD_TYPE=Release'
        '-DOPENSSL_ROOT_DIR=/usr/local/opt/openssl/'
        "-DCMAKE_INSTALL_PREFIX:PATH=$java_path/td"
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

$java_path = "$td/example/java"
$java_compile_destination = "$java_path/bin"


echo "java_path  : $java_path"

echo "java example path"
ls $java_path

echo "java td path"
ls $java_path/td

Push-Location $td/example/java/build
try {

    $cmakeArguments = @(
    '-DCMAKE_BUILD_TYPE=Release'
    "-DTd_DIR=$java_path/td/lib/cmake/Td"
    "-DCMAKE_INSTALL_PREFIX:PATH=.."
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



