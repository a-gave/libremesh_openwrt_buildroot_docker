# [WIP] LibreMesh OpenWrt Buildroot docker

A set of dockerfiles to build [LibreMesh](https://libremesh.org/) using a precompiled OpenWrt BuildRoot.

Some images are available also in the official docker registry 
They are huge (9-10GB), however the download could be faster than build all from scratch.
```
docker pull agave0/openwrt-buildroot:ath79-generic-v23.05.5
```

Summary of benefits:
- efficiently and fastly test which device fails:
  - too small (running make with `-i` or `--ignore-errors`)
  - version_dist hardcoded 8chars (firmware-utils)
  - firmware-utils use custom messages to say the initramfs/sysupgrade/factory was too big (maybe a sort of numeric error codes could be asked/proposed)
- this turns out something similar to `make clean` but that if you turn it off and on again it has already compiled everything and all the kernel_modules (if you don't need to modify the kernel)
- shared kmods:
  - across different flavors
  - could eventually be used by a ci to rebuild libremesh firmwares at commit (maybe only for a subset of targets)
  - this by producing a kind of snapshot that however keep the same kernel modules in common, when not varying the underlying openwrt distribution

todos:
- resetup the share of same toolchain for same archs
- include scripts to generate configs/23.05.5/*.autogen
- publish the tools+toolchains docker images
- remove kernel modules that no one will ever want to install on libremesh, 
and that are more appropriate on a plain openwrt (video, sound)
- of openwrt 23.05.5 only 56/75 targets are built, check if all excluded_targets are really exotic
- eventually test external_toolchain on openwrt-24 
- eventually try with strace to understand which path are never touched and that could be safely removed

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

Shared between all docker images
| size      | time   | step                                              |
| --------- | ------ | ------------------------------------------------- |
| 80.6MB    |        | 0. debian:bullseye-slim                           |
| 795MB     |        | 1. install build system essentials                |
| 841MB     |        | 2. download openwrt                               |
| 1.09GB    |        | 3. download feeds                                 |
| 1.68GB    |        | 4. download kernel and packages related archives  |

*To update*
- build tools
- build toolchain
- make a first build without selecting any profile 

*Removed because external toolchain is broken in 23.05.5* [1]
Specific to each target/subtarget
| 2.28GB     |        | 5. download sdk and extract tools and toolchain (ath79/generic) |
| 10.5GB     | ~57min | 6. make a first build (ath79/generic)                           |


## Tests
Tests were made on:
- x86/64 running in qemu
- ath79/generic Ubiquiti LiteBeam M5 (XW)
- ath79/nand Meraki MR18

## Resources

- External Toolchain https://openwrt.org/docs/guide-developer/external_toolchain
- Build all host tools
  https://github.com/openwrt/openwrt/commit/ebabdff4017fe2ed14491908ebe00589de0da189
- Reusing toolchain
  https://forum.openwrt.org/t/reusing-openwrt-based-toolchain-as-external-toolchain/66989


[1] These packages comes without the correct versions:
  - `libatomic1`
  - `libc`
  - `libgcc1`
  - `libpthread`
  - `librt`
  - `libstdcpp6` 
  This error seems to disappear on 24.10.0-rc5
  A list of related fixes should includes at least:
  - scripts/ext-toolchain: implement external GCC version detection: https://github.com/openwrt/openwrt/pull/13735