param (
    $td = "$PSScriptRoot/td"
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path $td/build)) {
    New-Item -Type Directory $td/build
    New-Item -Type Directory $td/example/java/build

}

Push-Location $td/build
try {
    $cmakeArguments = @(
        '-DCMAKE_BUILD_TYPE=Release'
        '-DOPENSSL_ROOT_DIR=/usr/local/opt/openssl/'
        '-DTD_ENABLE_JNI=ON'
        '-DCMAKE_INSTALL_PREFIX:PATH=../example/java/td'
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


Push-Location $td/example/java/build
try {
    $cmakeArguments = @(
        '-DCMAKE_BUILD_TYPE=Release'
        '-DTd_DIR=../td/lib/cmake/Td'
        '-DCMAKE_INSTALL_PREFIX:PATH=..'
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
