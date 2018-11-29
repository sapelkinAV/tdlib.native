param (
    $td = "$PSScriptRoot/td",
    $Platform = 'x64-windows',
    [Parameter(Mandatory = $true)] $VcpkgToolchain
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path $td/build)) {
    New-Item -Type Directory $td/build
}

Push-Location $td/build
try {
    $vcpkgArguments = @(
        'install'
        "openssl:$platform"
        "zlib:$platform"
    )
    $cmakeArguments = @(
        "-DCMAKE_TOOLCHAIN_FILE=$VcpkgToolchain"
        '..'
    )
    $cmakeBuildArguments = @(
        '--build'
        '.'
        '--config'
        'Release'
    )

    if ($Platform -eq 'x64-windows') {
        $cmakeArguments += @('-A', 'X64')
    }

    vcpkg $vcpkgArguments
    if (!$?) {
        throw 'Cannot execute vcpkg'
    }

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
