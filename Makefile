XCODE_VERSION ?= $(shell xcodebuild -version 2>/dev/null |  perl -ne '/Xcode (\S+)/ && print "$$1";')
SWIFT_VERSION ?= $(shell swift --version |  perl -ne '/Swift version (\S+)/ && print "$$1";')

DOCKER_USER ?= "torarnv"
TAG := "xcode$(XCODE_VERSION)"

IMAGE := "$(DOCKER_USER)/icecc-create-x86_64-env:$(TAG)"

toolchain:
	@docker run --rm -v $(PWD):/out --env HOST_PWD=$(PWD) $(IMAGE) 2>/dev/null || \
		(export DOCKER_USER=$(USER) && $(MAKE) docker-image && $(MAKE) toolchain)

docker-image:
	@echo "\\n---- Building image for Xcode $(XCODE_VERSION) based on Swift version $(SWIFT_VERSION) ---\\n"
	@docker build . \
		--build-arg SWIFT_VERSION=$(SWIFT_VERSION) \
		--build-arg HOST_XCODE_VERSION=$(XCODE_VERSION) \
		-t $(IMAGE)

HOST_PWD ?= "\$$PWD"
TOOLCHAIN_FILENAME := "xcode-$(XCODE_VERSION)-x86_64.tar.gz"

icecc-env:
	@echo "\\n--- Creating x86_64 cross-compilation toolchain targeting Xcode $(XCODE_VERSION) ---\\n"
	@icecc-create-env clang 5>/tmp/filename
	@mv -v $$(cat /tmp/filename) $(TOOLCHAIN_FILENAME)
	@echo "\\nSuccess! Use this toolchain by exporting:\\n\\n" \
		"  ICECC_VERSION=\"x86_64:$(HOST_PWD)/$(TOOLCHAIN_FILENAME)\""
