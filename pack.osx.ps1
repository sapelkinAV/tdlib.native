$ErrorActionPreference = 'Stop'

Compress-Archive -Path ./td/example/java/bin/ -DestinationPath tdlib.osx.zip
Compress-Archive -Path  ./td/build/ -Update -DestinationPath tdlib.osx.zip
