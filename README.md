# [WIP] LibreMesh OpenWrt Buildroot docker

A set of dockerfiles to build [LibreMesh](https://libremesh.org/) using a precompiled OpenWrt BuildRoot.

## Build a single image
```
make \
  TARGET=x86 \
  SUBTARGET=64 \
  OPENWRT_VERSION=23.05.5 \
  EXTRA_IMAGE_NAME=
```

## Use the docker image
Start the container
```
docker run -it libremesh/openwrt-buildroot:x86-64-v23.05.5
```
From inside the container select a device from menuconfig
```
make menuconfig
```
Build libremesh for that device
```
date ; make -j$(nproc) > build_log.txt 2>&1 ; date
```

## Images sizes and time
This example is based on a pc 4core, 16GB ram, not SSD.    
Every step depends also on network resources.

**Dockerfile steps**
[OUTDATED]
| size      | time   | step                                  |
| --------- | ------ | ------------------------------------- |
| 80.5MB    |        | 0. debian:bullseye-slim               |
| 875.0MB   |        | 1. install build system essentials    |
| 1.11GB    |        | 2. download openwrt and feeds         |
| 1.8GB     |        | 3. download precompiled sdk and extract tools and toolchain (x86/64) |
| 7.01GB    | ~40min | 4. make a first build (x86/64)        |
| 4.6GB     | ~15min | 4. make a first build (ath79/generic) |

**Time to compile:**   
- ~3min to build a single profile (x86/64 or ath79/generic)
- ~5min to build with additional packages or multi profiles
- ~32min to build all profiles in ath79/generic
  - with around 10 devices excluded because of small flash size
  - without additional packages

## Tests
Tests were made on:
- x86/64 running in qemu
- ath79/generic a real device Ubiquiti LiteBeam M5 (XW)

## Resources

- External Toolchain https://openwrt.org/docs/guide-developer/external_toolchain
- Build all host tools
  https://github.com/openwrt/openwrt/commit/ebabdff4017fe2ed14491908ebe00589de0da189
- Reusing toolchain
  https://forum.openwrt.org/t/reusing-openwrt-based-toolchain-as-external-toolchain/66989
