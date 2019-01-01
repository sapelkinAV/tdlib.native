param (
    $td = "$PSScriptRoot/td"
)

$ErrorActionPreference = 'Stop'


$build_path = "$td/build"
$java_path = "$td/example/java"

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
         "-DCMAKE_INSTALL_PREFIX:PATH=../example/java/td"
        '-DTD_ENABLE_JNI=ON'
        '..'
    )
    $cmakeBuildArguments = @(
        '--build'
        '.'
        '--target'
        'install'
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
    '--target'
    'install'
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

