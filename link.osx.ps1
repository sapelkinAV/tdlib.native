



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


New-Item -Type Directory $td/example/java/build
