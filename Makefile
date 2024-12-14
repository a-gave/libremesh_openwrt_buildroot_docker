
TARGET?=x86
SUBTARGET?=64
OPENWRT_VERSION?=23.05.5
DOCKER_EXTRA_IMAGE_NAME=$(if $(EXTRA_IMAGE_NAME),-$(EXTRA_IMAGE_NAME),)
TAG=${TARGET}-${SUBTARGET}-v${OPENWRT_VERSION}${DOCKER_EXTRA_IMAGE_NAME}
REPOSITORY=libremesh/openwrt-buildroot

all: 

	echo "Building ${TAG}"

	mkdir -p docker-build-logs~

	docker build . \
		--build-arg OPENWRT_VERSION=${OPENWRT_VERSION} \
		--build-arg TARGET=${TARGET} \
		--build-arg SUBTARGET=${SUBTARGET} \
		--file ./Dockerfile \
		--tag ${REPOSITORY}:${TAG} \
		> docker-build-logs~/${TAG}.txt 2>&1
