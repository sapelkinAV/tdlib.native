$ErrorActionPreference = 'Stop'

choco install gperf
if (!$?) { throw 'Cannot install dependencies from choco' }

choco install vcpkg
if (!$?) { throw 'Cannot install vcpkg from choco' }

vcpkg install openssl:x64-windows openssl:x86-windows zlib:x64-windows zlib:x86-windows
if (!$?) { throw 'Cannot install vcpkg dependencies' }

git submodule update --init --recursive
