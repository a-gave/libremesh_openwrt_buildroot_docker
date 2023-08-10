FROM debian:bullseye

RUN apt update -y && apt install -y \
      build-essential \
      clang \
      flex \
      bison \
      g++ \
      gawk \
      gcc-multilib \
      g++-multilib \
      gettext \
      git \
      libncurses-dev \
      libssl-dev \
      python3-distutils \
      rsync \
      unzip \
      zlib1g-dev \
      file \
      wget \
      qemu-utils \
      && apt-get autoremove -y \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG USER=builder

RUN useradd $USER \
  && mkdir -p /builder \
  && chown -R $USER:$USER /builder

USER $USER

RUN git clone -b v22.03.5 --single-branch https://git.openwrt.org/openwrt/openwrt.git /builder \
    && cd /builder \
    && ./scripts/feeds update -a \
    && ./scripts/feeds install -a

WORKDIR /builder

# RUN make defconfig ; make -j$(nproc) download world




