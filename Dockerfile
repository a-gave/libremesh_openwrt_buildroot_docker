FROM debian:bullseye-slim as buildroot_base

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
  qemu-utils \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV USER=builder

RUN adduser $USER \
  && mkdir -p /builder \
  && chown -R $USER:$USER /builder

USER $USER

FROM buildroot_base as buildroot_setup

ARG OPENWRT_VERSION
ENV OPENWRT_VERSION=${OPENWRT_VERSION:-23.05.5}

# speed up and save space:
# 0- download openwrt archive instead of git cloning
# 1- remove unused feed telephony
# 2- use github for openwrt feeds
# 3- remove histories of luci (~400MB) packages (~70MB) routing (~3MB) 
# 4- remove openwrt feeds in feeds.conf after install
RUN cd /tmp/ && wget https://github.com/openwrt/openwrt/archive/refs/tags/v${OPENWRT_VERSION}.tar.gz \
  && tar -xvf v${OPENWRT_VERSION}.tar.gz && rm v${OPENWRT_VERSION}.tar.gz \
  && mv openwrt-${OPENWRT_VERSION}/* /builder 

WORKDIR /builder

RUN cp feeds.conf.default feeds.conf \
  && sed -i 's|\(.*\)telephony\(.*\)||' feeds.conf \
  && sed -i 's|git.openwrt.org/project|github.com/openwrt|g' feeds.conf \
  && sed -i 's|git.openwrt.org/feed|github.com/openwrt|g' feeds.conf \
  && ./scripts/feeds update -a \
  && ./scripts/feeds install -a \
  && rm -rf feeds/luci/.git* feeds/packages/.git* feeds/routing/.git*

RUN echo " \n\
src-git libremesh https://github.com/libremesh/lime-packages.git;master \n\
src-git profiles https://github.com/libremesh/network-profiles.git" >> feeds.conf \
  && ./scripts/feeds update libremesh profiles \
  && ./scripts/feeds install -p libremesh -f -a \
  && ./scripts/feeds install -p profiles -f -a 

FROM buildroot_setup as buildroot_patch

COPY tools.patch ./

RUN git apply tools.patch

FROM buildroot_patch as buildroot_download

# download kernel (121MB) and default_packages (59MB) and archives related to lime-packages
RUN PACKAGES=$(grep 'Package:' feeds/libremesh.index | sed 's|Package: ||g') \
  && for p in $PACKAGES; do echo "CONFIG_PACKAGE_$p=m" >> .config ; done \
  && make defconfig \
  && make target/linux/download \
  && make package/download \
  && rm -rf .config staging_dir/target* staging_dir/toolchain*

FROM buildroot_download as buildroot_prepare

ARG TARGET
ENV TARGET ${TARGET:-x86} 
ARG SUBTARGET
ENV SUBTARGET ${SUBTARGET:-64}

# tools and toolchain
RUN wget -nd --no-parent \
    -r https://downloads.openwrt.org/releases/$OPENWRT_VERSION/targets/$TARGET/$SUBTARGET/ \
    -A 'openwrt-sdk*.tar.xz' \
  && tar -xvf openwrt-sdk*.tar.xz \
  && rm -rf staging_dir/host \
  && mv openwrt-sdk*/staging_dir/host staging_dir/ \
  && mv openwrt-sdk*/staging_dir/toolchain* staging_dir/ \
  && rm -rf openwrt-sdk* \

FROM buildroot_prepare as buildroot_first_build

# precompile all packages from libremesh
RUN PACKAGES=$(grep 'Package:' feeds/libremesh.index | sed 's|Package: ||g') \
  && for p in $PACKAGES; do echo "CONFIG_PACKAGE_$p=m" >> .config ; done 

RUN echo "\n\
\nCONFIG_DEVEL=y \
\nCONFIG_EXTERNAL_TOOLS=y \
\nCONFIG_ALL_NONSHARED=y \
\nCONFIG_TARGET_ROOTFS_INITRAMFS=y \
\nCONFIG_IMAGEOPT=y \
\nCONFIG_VERSIONOPT=y " >> .config \
  && EXT_TOOLCHAIN_NAME=$(ls staging_dir/ | grep toolchain) \
  && ./scripts/ext-toolchain.sh \
    --toolchain staging_dir/$EXT_TOOLCHAIN_NAME \
    --overwrite-config --config $TARGET/$SUBTARGET \ 
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
\n# CONFIG_PACKAGE_kmod-ppp is not set \
\n# CONFIG_PACKAGE_kmod-pppoe is not set \
\n# CONFIG_PACKAGE_kmod-pppox is not set \
\nCONFIG_PACKAGE_profile-libremesh-suggested-packages-tiny=y" >> .config \
  && make defconfig \
  && ionice -c 3 chrt --idle 0 nice -n19 make -j$(($(nproc)+1)) IGNORE_ERRORS="n m" > build_log.txt 2>&1
