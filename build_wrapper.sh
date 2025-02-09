#!/bin/bash

OPENWRT_VERSION=${OPENWRT_VERSION:-23.05.5}
DATE=""
LIBREMESH_REVISION=";v2024.1"
EXTRA_IMAGE_NAME=

targets_all=($(curl -s "https://downloads.openwrt.org/releases/${OPENWRT_VERSION}/.targets.json" | sed 's|.*\"\(.*\)\"\:.*|\1|g' | tail -n +2 | head -n -1 | sort | sed 's|/|-|g'))
skip_targets=($(cat ./excluded_targets | sort | sed 's|/|-|g' ))

targets=()
for i in ${!targets_all[@]}; do 
	if printf '%s\0' "${skip_targets[@]}" | grep -Fxqz -- ${targets_all[$i]}; then echo "skip ${targets_all[$i]}" ; else targets+=(${targets_all[$i]}) ; fi
done


N=8
for i in ${!targets[@]}; do 
  TARGET=$(echo ${targets[$i]} | cut -d '-' -f 1)
  SUBTARGET=$(echo ${targets[$i]} | cut -d '-' -f 2)
  TAG=${TARGET}-${SUBTARGET}-v${OPENWRT_VERSION}${EXTRA_IMAGE_NAME}

  sem -j $N "TARGET=$TARGET SUBTARGET=$SUBTARGET DATE=$DATE LIBREMESH_REVISION=\"$LIBREMESH_REVISION\" ./build.sh"
done
sem --wait
