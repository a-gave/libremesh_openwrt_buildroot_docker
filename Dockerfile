FROM debian:11-slim

ARG DEBIAN_FRONTEND=noninteractive

USER root

RUN \
	apt-get update && \
	apt-get install -y --no-install-recommends \
		build-essential \
		ccache \
		curl \
		file \
		gawk \
		g++-multilib \
		gcc-multilib \
		genisoimage \
		git-core \
		gosu \
		libdw-dev \
		libelf-dev \
		libncurses5-dev \
		locales \
		pv \
		pwgen \
		python3 \
		python3-venv \
		python3-pip \
		python3-pyelftools \
		python3-cryptography \
		qemu-utils \
		rsync \
		signify-openbsd \
		subversion \
		swig \
		unzip \
		wget \
    zstd && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV USER=builder

RUN adduser $USER \
  && mkdir -p /builder \
  && chown -R $USER:$USER /builder

USER $USER

ARG OPENWRT_VERSION
ENV OPENWRT_VERSION=${OPENWRT_VERSION:-23.05.5}

RUN cd /tmp/ && wget https://github.com/openwrt/openwrt/archive/refs/tags/v${OPENWRT_VERSION}.tar.gz \
  && tar -xvf v${OPENWRT_VERSION}.tar.gz \
  && mv openwrt-${OPENWRT_VERSION}/* /builder \
  && rm -rf /tmp/*

WORKDIR /builder

COPY scripts_feeds.patch tools.patch ./

RUN git apply scripts_feeds.patch \
  && git apply tools.patch

RUN cp feeds.conf.default feeds.conf \
  && sed -i '/.*telephony.*/d' feeds.conf \
  && sed -i 's/git.openwrt.org\/\(project\|feed\)/github.com\/openwrt/g' feeds.conf \
  && ./scripts/feeds update -a \
  && ./scripts/feeds install -a

RUN echo " \n\
src-git libremesh https://github.com/libremesh/lime-packages.git;master \n\
src-git profiles https://github.com/libremesh/network-profiles.git" >> feeds.conf \
  && ./scripts/feeds update libremesh profiles \
  && ./scripts/feeds install -p libremesh \
  && ./scripts/feeds install -p profiles

# do not build tool llvm-bpf
RUN echo "\n\
\nCONFIG_DEVEL=y \
\nCONFIG_BUILD_ALL_HOST_TOOLS=y" > .config \
  && make defconfig \
  && sed -i 's|^.*llvm-bpf.*$||g' tools/Makefile \ 
  && make tools/download \
  && make -j1 tools/compile \
  && make -j1 tools/install \
  && rm -rf .config staging_dir/target* staging_dir/toolchain* build_dir/host* build_dir/target* dl/* bin/*

# download kernel (121MB) and default_packages (59MB) and archives related to lime-packages
RUN echo "\n\
\nCONFIG_DEVEL=y \
\nCONFIG_ALL_KMODS=y \
\nCONFIG_PACKAGE_profile-libremesh-suggested-packages=y" > .config \
  && make defconfig \
  && make target/linux/download \
  && make package/download \
  && rm -rf .config staging_dir/target* staging_dir/toolchain* bin/*

ARG TARGET
ENV TARGET ${TARGET:-x86} 
ARG SUBTARGET
ENV SUBTARGET ${SUBTARGET:-64}

RUN echo "\n\
\nCONFIG_DEVEL=y \
\nCONFIG_EXTERNAL_TOOLS=y \
\nCONFIG_TARGET_${TARGET}=y \
\nCONFIG_TARGET_${TARGET}_${SUBTARGET}=y" >> .config \
  && make defconfig \
  && make -j1 toolchain/compile \
  && find build_dir/toolchain* ! -name '.built*' ! -name '.configured*' ! -name '.prepared*' -type f -exec rm -f {} + \
  && find build_dir/toolchain* -type d -empty -delete

RUN rm .config \
  && echo "\n\
\nCONFIG_DEVEL=y \
\nCONFIG_EXTERNAL_TOOLS=y \
\nCONFIG_ALL_KMODS=y \
\nCONFIG_ALL_NONSHARED=y \
\nCONFIG_TARGET_${TARGET}=y \
\nCONFIG_TARGET_${TARGET}_${SUBTARGET}=y \
\nCONFIG_TARGET_ROOTFS_INITRAMFS=y \
\nCONFIG_TARGET_MULTI_PROFILE=y \
\nCONFIG_TARGET_PER_DEVICE_ROOTFS=y \
\nCONFIG_IMAGEOPT=y \
\nCONFIG_VERSIONOPT=y" >> .config \
  && make defconfig \
  && echo "\n\
\nCONFIG_KERNEL_BUILD_DOMAIN=\"buildhost\" \
\nCONFIG_VERSION_DIST=\"LibreMesh\" \
\nCONFIG_VERSION_NUMBER=\"$(cd feeds/libremesh && git rev-parse --short=7 HEAD)-${OPENWRT_VERSION}\" \
\n# CONFIG_VERSION_CODE_FILENAMES is not set \
\n# CONFIG_FEED_libremesh is not set \
\n# CONFIG_FEED_profiles is not set \
\n# CONFIG_PACKAGE_dnsmasq is not set \
\n# CONFIG_PACKAGE_odhcpd-ipv6only is not set \
\n# CONFIG_PACKAGE_ppp is not set \
\n# CONFIG_PACKAGE_ppp-mod-pppoe is not set \
\nCONFIG_PACKAGE_kmod-ppp=m \
\nCONFIG_PACKAGE_kmod-pppoe=m \
\nCONFIG_PACKAGE_kmod-pppox=m \
\nCONFIG_PACKAGE_profile-libremesh-suggested-packages=y" >> .config \
  && make defconfig
   
RUN make -j1 V=sc IGNORE_ERRORS="n m"
