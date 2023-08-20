#!/bin/bash
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=bcm27xx --build-arg ARCH_SUBTARGET=bcm2710 --build-arg TARGET=bcm27xx --build-arg SUBTARGET=bcm2710 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:bcm27xx-bcm2710-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=bcm27xx --build-arg ARCH_SUBTARGET=bcm2710 --build-arg TARGET=bcm4908 --build-arg SUBTARGET=generic --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:bcm4908-generic-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=bcm27xx --build-arg ARCH_SUBTARGET=bcm2710 --build-arg TARGET=mvebu --build-arg SUBTARGET=cortexa53 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:mvebu-cortexa53-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=bcm27xx --build-arg ARCH_SUBTARGET=bcm2710 --build-arg TARGET=mediatek --build-arg SUBTARGET=mt7622 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:mediatek-mt7622-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=bcm27xx --build-arg ARCH_SUBTARGET=bcm2710 --build-arg TARGET=sunxi --build-arg SUBTARGET=cortexa53 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:sunxi-cortexa53-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=mediatek --build-arg ARCH_SUBTARGET=mt7629 --build-arg TARGET=mediatek --build-arg SUBTARGET=mt7629 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:mediatek-mt7629-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=ipq40xx --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=bcm27xx --build-arg SUBTARGET=bcm2709 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:bcm27xx-bcm2709-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=ipq40xx --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=ipq40xx --build-arg SUBTARGET=generic --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ipq40xx-generic-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=ipq40xx --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=ipq40xx --build-arg SUBTARGET=mikrotik --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ipq40xx-mikrotik-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=ipq40xx --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=layerscape --build-arg SUBTARGET=armv7 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:layerscape-armv7-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=ipq40xx --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=mediatek --build-arg SUBTARGET=mt7623 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:mediatek-mt7623-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=ipq40xx --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=sunxi --build-arg SUBTARGET=cortexa7 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:sunxi-cortexa7-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=ipq806x --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=ipq806x --build-arg SUBTARGET=generic --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ipq806x-generic-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=ath79 --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=ath79 --build-arg SUBTARGET=generic --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ath79-generic-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=ath79 --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=ath79 --build-arg SUBTARGET=mikrotik --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ath79-mikrotik-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=ath79 --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=ath79 --build-arg SUBTARGET=nand --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ath79-nand-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=ath79 --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=ath79 --build-arg SUBTARGET=tiny --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ath79-tiny-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=ath79 --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=lantiq --build-arg SUBTARGET=xrx200 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:lantiq-xrx200-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=ath79 --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=lantiq --build-arg SUBTARGET=xway --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:lantiq-xway-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=ath79 --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=realtek --build-arg SUBTARGET=rtl839x --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:realtek-rtl839x-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=ath79 --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=realtek --build-arg SUBTARGET=rtl930x --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:realtek-rtl930x-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=realtek --build-arg ARCH_SUBTARGET=rtl838x --build-arg TARGET=realtek --build-arg SUBTARGET=rtl838x --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:realtek-rtl838x-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=bcm63xx --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=ath25 --build-arg SUBTARGET=generic --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ath25-generic-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=bcm63xx --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=bcm63xx --build-arg SUBTARGET=generic --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:bcm63xx-generic-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=bcm63xx --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=bcm63xx --build-arg SUBTARGET=smp --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:bcm63xx-smp-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=ramips --build-arg ARCH_SUBTARGET=mt7620 --build-arg TARGET=ramips --build-arg SUBTARGET=mt76x8 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ramips-mt76x8-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=ramips --build-arg ARCH_SUBTARGET=mt7620 --build-arg TARGET=ramips --build-arg SUBTARGET=mt7620 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ramips-mt7620-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=ramips --build-arg ARCH_SUBTARGET=mt7620 --build-arg TARGET=ramips --build-arg SUBTARGET=mt7621 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ramips-mt7621-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=ramips --build-arg ARCH_SUBTARGET=mt7620 --build-arg TARGET=ramips --build-arg SUBTARGET=rt288x --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ramips-rt288x-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=ramips --build-arg ARCH_SUBTARGET=mt7620 --build-arg TARGET=ramips --build-arg SUBTARGET=rt305x --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ramips-rt305x-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=ramips --build-arg ARCH_SUBTARGET=rt3883 --build-arg TARGET=bcm47xx --build-arg SUBTARGET=mips74k --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:bcm47xx-mips74k-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=ramips --build-arg ARCH_SUBTARGET=rt3883 --build-arg TARGET=ramips --build-arg SUBTARGET=rt3883 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ramips-rt3883-v22.03.5-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=22.03.5 --build-arg ARCH_TARGET=x86 --build-arg ARCH_SUBTARGET=64 --build-arg TARGET=x86 --build-arg SUBTARGET=64 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:x86-64-v22.03.5-ext-toolchain 
