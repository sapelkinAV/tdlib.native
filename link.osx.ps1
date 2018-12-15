
param (
    $td = "$PSScriptRoot/td"
)


$java_path = "$td/example/java"
$java_compile_destination = "$java_path/bin"


echo "java_path  : $java_path"
echo "java_compile_destination : $java_compile_destination"

echo "java example path"
ls $java_path

echo "java td"
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

