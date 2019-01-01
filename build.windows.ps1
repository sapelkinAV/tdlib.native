param (
    $td = "$PSScriptRoot/td",
    $Platform = 'x64-windows',
    [Parameter(Mandatory = $true)] $VcpkgToolchain
)


$build_path = "$td/build"
$java_path = "$td/example/java"
$java_compile_destination = "$java_path/bin"

$ErrorActionPreference = 'Stop'

if (-not (Test-Path $td/build)) {
    New-Item -Type Directory $td/build
}
if (-not (Test-Path $td/example/java/build)) {
    New-Item -Type Directory $td/example/java/build
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
        "-DCMAKE_INSTALL_PREFIX:PATH=../example/java/td"
        '..'
    )
    $cmakeBuildArguments = @(
        '--build'
        '.'
        '--target'
        'install'
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

