ARG SWIFT_VERSION=latest
FROM swift:$SWIFT_VERSION

ARG HOST_XCODE_VERSION=latest
ENV XCODE_VERSION=$HOST_XCODE_VERSION

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

COPY Makefile /tmp/Makefile

CMD make -f /tmp/Makefile icecc-env
