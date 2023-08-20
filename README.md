# LibreMesh OpenWrt Buildroot docker

A set of dockerfiles to build [LibreMesh](https://libremesh.org/) using a precompiled Buildroot for different openwrt boards.

## Build and run a single image
```
docker-compose up -d
```

## Use the docker image

Start the container
```
docker run -it libremesh/openwrt-buildroot:ath79-generic-v22.03.5
```
From inside the container select a device from menuconfig
```
make menuconfig
```
Build libremesh for that device
```
START=$(date) && echo $START && make -j$(nproc) && echo $START && date
```
It should take approximately 3 minutes depending on the resources of the machine that builds. Up to 4-5 minutes if you select additional packages.

## Sizes

The default `Dockerfile` compile a toolchain that will be shared with targets based on the same architecture. This is thinked to speedup the build process and to let docker images share and so reuse as much docker build step as possibile.

The `Dockerfile.ext-toolchain` use an official toolchain from https://downloads.openwrt.org as described on the guide [0] and then share it with targets that are based on the same architecture.

The size of the produced docker images, comparing ath79/generic are:
- around 11.2GB for the default
- around 6.56GB using an external toolchain


### Details about image sizes
Comparing the produced docker images for target `ath79/generic`.

#### common
from debian:bullseye-slim: 80.5MB      
after installing required system tools: 868MB      
after cloning openwrt and installing feeds: 1.54GB

#### 1. using default Dockerfile
after building the toolchain: 4.18GB      
after compiling target and packages: 11.2GB

#### 2. using Dockerfile.ext-toolchain
after downloading the external toolchain: 4.63GB       
after compiling target and packages: 6.56GB       


## References

[0] https://openwrt.org/docs/guide-developer/external_toolchain

## Resources
Build all host tools
https://github.com/openwrt/openwrt/commit/ebabdff4017fe2ed14491908ebe00589de0da189

Reusing toolchain
https://forum.openwrt.org/t/reusing-openwrt-based-toolchain-as-external-toolchain/66989
