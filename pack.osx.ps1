$ErrorActionPreference = 'Stop'

Compress-Archive ./td/example/java/bin/* ./td/build/*.dylib ./td/build/*.a tdlib.osx.zip
