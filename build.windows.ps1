param (
    $td = "$PSScriptRoot/td",
    $platform = 'x64-windows',
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
        '-DTD_ENABLE_JNI=ON'
        '..'
    )
    $cmakeBuildArguments = @(
        '--build'
        '.'
        '--config'
        'Release'
    )

    if ($platform -eq 'x64-windows') {
        $cmakeArguments += @('-A', 'X64')
    }

    # vcpkg $vcpkgArguments
    # if (!$?) {
    #     throw 'Cannot execute vcpkg'
    # }

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
