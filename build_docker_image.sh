#!/bin/sh

TARGET=${TARGET:-x86}
SUBTARGET=${SUBTARGET:-64}
OPENWRT_VERSION=${OPENWRT_VERSION:-23.05.5}
EXTRA_IMAGE_NAME=
TAG=${TARGET}-${SUBTARGET}-v${OPENWRT_VERSION}${EXTRA_IMAGE_NAME}

docker build . \
  --build-arg OPENWRT_VERSION=${OPENWRT_VERSION} \
  --build-arg TARGET=${TARGET} \
  --build-arg SUBTARGET=${SUBTARGET} \
  --file ./Dockerfile \
  --tag libremesh/buildroot:${TAG} | tee logs/$TAG.txt