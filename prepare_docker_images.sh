#!/bin/bash

OPENWRT_VERSION=${OPENWRT_VERSION:-23.05.5}
EXTRA_IMAGE_NAME=

targets_all=($(curl -s "https://downloads.openwrt.org/releases/${OPENWRT_VERSION}/.targets.json" | sed 's|.*\"\(.*\)\"\:.*|\1|g' | tail -n +2 | head -n -1 | sort -r | sed 's|/|-|g'))
skip_targets=($(cat ./excluded_targets | sort | sed 's|/|-|g' ))

targets=()
for i in ${!targets_all[@]}; do 
	if printf '%s\0' "${skip_targets[@]}" | grep -Fxqz -- ${targets_all[$i]}; then echo "skip ${targets_all[$i]}" ; else targets+=(${targets_all[$i]}) ; fi
done


# use 6/8 core
N=6
for i in ${!targets[@]}; do 
  TARGET=$(echo ${targets[$i]} | cut -d '-' -f 1)
  SUBTARGET=$(echo ${targets[$i]} | cut -d '-' -f 2)

  sem -j $N "TARGET=$TARGET SUBTARGET=$SUBTARGET OPENWRT_VERSION=$OPENWRT_VERSION ./build_docker_image.sh"
done
sem --wait
