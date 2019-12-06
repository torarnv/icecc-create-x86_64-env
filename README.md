Convenience for creating Icecream toolchains to cross-compile
on `x86_64` hosts targeting Xcode's build environment.

# Creating toolchain

## Via Docker Hub

`docker run --rm -v $(pwd):/out torarnv/icecc-create-x86_64-env`

For available tags see [docker hub](https://hub.docker.com/r/torarnv/icecc-create-x86_64-env/tags).

## Locally

`make`

# Using toolchain

The finished environment is written to the current working directory.

Tell Icecream to use it when cross-compiling by running:

`export ICECC_VERSION=x86_64:$(pwd)/xcode-11.2.1-x86_64.tar.gz`
