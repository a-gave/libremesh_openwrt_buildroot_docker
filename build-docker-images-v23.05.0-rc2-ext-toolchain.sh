#!/bin/bash
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=bcm27xx --build-arg ARCH_SUBTARGET=bcm2710 --build-arg TARGET=bcm27xx --build-arg SUBTARGET=bcm2710 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:bcm27xx-bcm2710-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=bcm27xx --build-arg ARCH_SUBTARGET=bcm2710 --build-arg TARGET=bcm4908 --build-arg SUBTARGET=generic --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:bcm4908-generic-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=bcm27xx --build-arg ARCH_SUBTARGET=bcm2710 --build-arg TARGET=ipq807x --build-arg SUBTARGET=generic --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ipq807x-generic-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=bcm27xx --build-arg ARCH_SUBTARGET=bcm2710 --build-arg TARGET=mvebu --build-arg SUBTARGET=cortexa53 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:mvebu-cortexa53-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=bcm27xx --build-arg ARCH_SUBTARGET=bcm2710 --build-arg TARGET=mediatek --build-arg SUBTARGET=mt7622 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:mediatek-mt7622-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=bcm27xx --build-arg ARCH_SUBTARGET=bcm2710 --build-arg TARGET=mediatek --build-arg SUBTARGET=filogic --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:mediatek-filogic-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=bcm27xx --build-arg ARCH_SUBTARGET=bcm2710 --build-arg TARGET=sunxi --build-arg SUBTARGET=cortexa53 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:sunxi-cortexa53-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=mediatek --build-arg ARCH_SUBTARGET=mt7629 --build-arg TARGET=mediatek --build-arg SUBTARGET=mt7629 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:mediatek-mt7629-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ipq40xx --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=bcm27xx --build-arg SUBTARGET=bcm2709 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:bcm27xx-bcm2709-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ipq40xx --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=imx --build-arg SUBTARGET=cortexa7 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:imx-cortexa7-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ipq40xx --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=ipq40xx --build-arg SUBTARGET=chromium --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ipq40xx-chromium-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ipq40xx --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=ipq40xx --build-arg SUBTARGET=generic --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ipq40xx-generic-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ipq40xx --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=ipq40xx --build-arg SUBTARGET=mikrotik --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ipq40xx-mikrotik-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ipq40xx --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=layerscape --build-arg SUBTARGET=armv7 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:layerscape-armv7-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ipq40xx --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=mediatek --build-arg SUBTARGET=mt7623 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:mediatek-mt7623-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ipq40xx --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=sunxi --build-arg SUBTARGET=cortexa7 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:sunxi-cortexa7-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ipq806x --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=armsr --build-arg SUBTARGET=armv7 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:armsr-armv7-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ipq806x --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=ipq806x --build-arg SUBTARGET=chromium --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ipq806x-chromium-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ipq806x --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=ipq806x --build-arg SUBTARGET=generic --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ipq806x-generic-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ath79 --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=ath79 --build-arg SUBTARGET=generic --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ath79-generic-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ath79 --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=ath79 --build-arg SUBTARGET=mikrotik --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ath79-mikrotik-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ath79 --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=ath79 --build-arg SUBTARGET=nand --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ath79-nand-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ath79 --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=ath79 --build-arg SUBTARGET=tiny --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ath79-tiny-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ath79 --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=lantiq --build-arg SUBTARGET=xrx200 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:lantiq-xrx200-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ath79 --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=lantiq --build-arg SUBTARGET=xway --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:lantiq-xway-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ath79 --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=realtek --build-arg SUBTARGET=rtl839x --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:realtek-rtl839x-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ath79 --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=realtek --build-arg SUBTARGET=rtl930x --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:realtek-rtl930x-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=realtek --build-arg ARCH_SUBTARGET=rtl838x --build-arg TARGET=realtek --build-arg SUBTARGET=rtl838x --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:realtek-rtl838x-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=bcm63xx --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=ath25 --build-arg SUBTARGET=generic --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ath25-generic-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=bcm63xx --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=bcm63xx --build-arg SUBTARGET=generic --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:bcm63xx-generic-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=bcm63xx --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=bcm63xx --build-arg SUBTARGET=smp --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:bcm63xx-smp-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ramips --build-arg ARCH_SUBTARGET=mt7620 --build-arg TARGET=ramips --build-arg SUBTARGET=mt76x8 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ramips-mt76x8-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ramips --build-arg ARCH_SUBTARGET=mt7620 --build-arg TARGET=ramips --build-arg SUBTARGET=mt7620 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ramips-mt7620-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ramips --build-arg ARCH_SUBTARGET=mt7620 --build-arg TARGET=ramips --build-arg SUBTARGET=mt7621 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ramips-mt7621-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ramips --build-arg ARCH_SUBTARGET=mt7620 --build-arg TARGET=ramips --build-arg SUBTARGET=rt288x --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ramips-rt288x-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ramips --build-arg ARCH_SUBTARGET=mt7620 --build-arg TARGET=ramips --build-arg SUBTARGET=rt305x --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ramips-rt305x-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=pistachio --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=pistachio --build-arg SUBTARGET=generic --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:pistachio-generic-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ramips --build-arg ARCH_SUBTARGET=rt3883 --build-arg TARGET=bcm47xx --build-arg SUBTARGET=mips74k --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:bcm47xx-mips74k-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=ramips --build-arg ARCH_SUBTARGET=rt3883 --build-arg TARGET=ramips --build-arg SUBTARGET=rt3883 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:ramips-rt3883-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=bcm47xx --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=bcm47xx --build-arg SUBTARGET=generic --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:bcm47xx-generic-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=bcm47xx --build-arg ARCH_SUBTARGET=generic --build-arg TARGET=bcm47xx --build-arg SUBTARGET=legacy --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:bcm47xx-legacy-v23.05.0-rc2-ext-toolchain 
docker build . --build-arg OPENWRT_VERSION=23.05.0-rc2 --build-arg ARCH_TARGET=x86 --build-arg ARCH_SUBTARGET=64 --build-arg TARGET=x86 --build-arg SUBTARGET=64 --file ./Dockerfile.ext-toolchain --tag libremesh/openwrt-buildroot:x86-64-v23.05.0-rc2-ext-toolchain 
