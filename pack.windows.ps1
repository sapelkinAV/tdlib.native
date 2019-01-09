$ErrorActionPreference = 'Stop'


Compress-Archive -Path ./td/example/java/ -DestinationPath tdlib.windows.zip
Compress-Archive -Path  ./td/build/ -Update -DestinationPath tdlib.windows.zip
