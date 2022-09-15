ARG SWIFT_VERSION=latest
FROM swift:$SWIFT_VERSION

ARG HOST_XCODE_VERSION=latest
ENV XCODE_VERSION=$HOST_XCODE_VERSION

LABEL maintainer="Tor Arne Vestbø <torarnv@gmail.com>"

RUN apt-get update && apt-get -q install -y \
		icecc \
		make

VOLUME /out
WORKDIR /out

COPY Makefile /tmp/Makefile

CMD make -f /tmp/Makefile icecc-env
