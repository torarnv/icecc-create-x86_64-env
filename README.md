Docker file for creating Icecream x86_64 environments to match Xcode's build environment

## Usage

`docker run --rm -v $(pwd):/out torarnv/icecc-create-x86_64-env`

Writes the finished environment to the current working directory. 

Then tell Icecream to use it when cross-compiling:

`export ICECC_VERSION=x86_64:$(pwd)/env.tar.gz`

For available tags see [docker hub](https://hub.docker.com/r/torarnv/icecc-create-x86_64-env/tags).

## Building

   1. Check which swift version is [bundled with the Xcode version](https://en.wikipedia.org/wiki/Xcode#Latest_versions)
   2. Verify that there's a corresponding [swift docker tag](https://hub.docker.com/_/swift)
   3. `docker build -t icecc-create-x86_64-env --build-arg SWIFT_VERSION=$swift_version .`
