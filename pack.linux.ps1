$ErrorActionPreference = 'Stop'

Compress-Archive -Path ./td/example/java/bin/ -DestinationPath tdlib.linux.zip
Compress-Archive -Path  ./td/build/ -Update -DestinationPath tdlib.linux.zip
