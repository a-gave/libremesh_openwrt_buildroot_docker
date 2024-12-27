#!/bin/bash
#
TARGET=x86
SUBTARGET=64
OPENWRT_VERSION=23.05.5
TAG=${TARGET}-${SUBTARGET}-v${OPENWRT_VERSION}
REPOSITORY=libremesh/openwrt-buildroot

if [ ! -d lime-packages ]; then
  git clone https://github.com/libremesh/lime-packages
fi

REV=$(cd lime-packages && git rev-parse --short=7 HEAD)

if [ ! -f .revision ]; then 
  echo $REV > .revision
elif [ $(echo $REV) == $(cat .revision) ]; then
    echo 'Unchanged'
    exit 0
else
  echo 'build'
  docker run -v $(pwd)/bin_dir/$TAG:/builder/bin --name $TAG $REPOSITORY:$TAG
  docker exec $TAG "scripts/feeds update -a; scripts/feeds install -a"
  docker exec $TAG "make -j$(nproc) > build_log.txt 2>&1"
fi
