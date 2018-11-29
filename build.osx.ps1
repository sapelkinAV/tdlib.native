param (
    $td = "$PSScriptRoot/td"
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path $td/build)) {
    New-Item -Type Directory $td/build
}

Push-Location $td/build
try {
    $cmakeArguments = @(
        '-DCMAKE_BUILD_TYPE=Release'
        '-DOPENSSL_ROOT_DIR=/usr/local/opt/openssl/'
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


Push-Location $td/example/java
try {

    md build
} finally {
    Pop-Location
}

Push-Location $td/example/java/build
try {
    cmake -DCMAKE_BUILD_TYPE=Release -DTd_DIR=$td/example/java/td/lib/cmake/Td -DCMAKE_INSTALL_PREFIX:PATH=.. ..
    cmake --build . --target install
} finally {
    Pop-Location
}
