FROM debian:bullseye-slim

RUN apt update -y && apt install -y \
  build-essential \
  ccache \
  ecj \
  fastjar \ 
  file \
  g++ \
  gawk \
  gettext \
  git \
  java-propose-classpath \
  libelf-dev \
  libncurses5-dev \
  libncursesw5-dev \
  libssl-dev \
  python \
  python2.7-dev \
  python3 \
  unzip \
  wget \
  python3-distutils-extra \
  python3-setuptools \
  python3-dev \
  rsync \
  subversion \
  swig \
  time \
  xsltproc \
  zlib1g-dev \
  qemu-utils

ENV USER=builder

RUN adduser $USER \
  && mkdir -p /builder \
  && chown -R $USER:$USER /builder

USER $USER

ARG OPENWRT_VERSION
ENV OPENWRT_VERSION=${OPENWRT_VERSION:-22.03.5}

RUN git clone -b $OPENWRT_VERSION --single-branch https://git.openwrt.org/openwrt/openwrt.git /builder \
  && cd /builder \
  && cp feeds.conf.default feeds.conf \
  && echo " \n\
src-git libremesh https://github.com/libremesh/lime-packages.git;master \n\
src-git profiles https://github.com/libremesh/network-profiles.git" >> feeds.conf \
  && ./scripts/feeds update -a \
  && ./scripts/feeds install -a 

WORKDIR /builder

ARG ARCH_TARGET
ENV ARCH_TARGET ${ARCH_TARGET:-ath79}
ARG ARCH_SUBTARGET
ENV ARCH_SUBTARGET ${ARCH_SUBTARGET:-generic}

RUN touch .config \
  && echo " \n\
CONFIG_DEVEL=y \n\
CONFIG_ALL_KMODS=y \n\
CONFIG_ALL_NONSHARED=y \n\
CONFIG_TARGET_${ARCH_TARGET}=y \n\
CONFIG_TARGET_${ARCH_TARGET}_${ARCH_SUBTARGET}=y \n\
CONFIG_TARGET_SUBTARGET=${ARCH_SUBTARGET} \n\
CONFIG_TARGET_MULTI_PROFILE=y \n\
CONFIG_TARGET_PER_DEVICE_ROOTFS=y " >> .config \
  && make defconfig 

# compile and clean toolchain, clean subtarget files
RUN make -j$(nproc) download \
  && make -j$(nproc) prepare \
  && find build_dir/toolchain* ! -name '.built*' ! -name '.configured*' ! -name '.prepared*' -type f -exec rm -f {} + \
  && find build_dir/toolchain* -type d -empty -delete \
  && find build_dir/host/ ! -name '.built*' ! -name '.configured*' ! -name '.prepared*' -type f -exec rm -f {} + \
  && find build_dir/host/ -type d -empty -delete \ 
  && rm -rf build_dir/target*/ \
  && rm -rf staging_dir/target*/

# target
ARG TARGET
ENV TARGET ${TARGET:-ath79} 
ARG SUBTARGET
ENV SUBTARGET ${SUBTARGET:-generic}

RUN echo " \n\
CONFIG_DEVEL=y \n\
CONFIG_ALL_KMODS=y \n\
CONFIG_ALL_NONSHARED=y \n\
CONFIG_TARGET_${TARGET}=y \n\
CONFIG_TARGET_${TARGET}_${SUBTARGET}=y \n\
CONFIG_TARGET_MULTI_PROFILE=y \n\
CONFIG_TARGET_PER_DEVICE_ROOTFS=y " >> .config \
  && make defconfig \
  && echo "\n# \
CONFIG_PACKAGE_dnsmasq is not set \n# \
CONFIG_PACKAGE_odhcpd-ipv6only is not set \n# \
CONFIG_PACKAGE_ppp is not set \n# \ 
CONFIG_PACKAGE_ppp-mod-pppoe is not set \n\
CONFIG_PACKAGE_profile-libremesh-suggested-packages=y" >> .config \
  && make defconfig \
  && make -j$(nproc)

