ARG SWIFT_VERSION=latest
FROM swift:$SWIFT_VERSION

LABEL maintainer="Tor Arne Vestbø <torarnv@gmail.com>"

ARG ICECREAM_REPO="https://github.com/icecc/icecream.git"

# Build latest Icecream from source
RUN apt-get update && apt-get -q install -y \
		autotools-dev \
		automake \
		libtool \
		liblzo2-dev \
		libzstd-dev \
		libarchive-dev && \
	git clone --depth 1 --single-branch $ICECREAM_REPO /src/icecream && \
	cd /src/icecream && \
	./autogen.sh && \
	./configure --with-libcap-ng=no --without-man && \
	make && \
	make install

VOLUME /out
WORKDIR /out

CMD icecc-create-env clang 5>/tmp/filename && \
	swift_version=$(swift -v 2>&1 |  perl -ne '/Swift version (\S+)/ && print "$1\n";') && \
	mv -v $(cat /tmp/filename) swift-llvm-$swift_version-x86_64.tar.gz
