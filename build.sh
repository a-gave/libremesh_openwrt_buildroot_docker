#!/bin/bash
#
# Save configs about excluded devices
#
TARGET=${TARGET:-ath79}
SUBTARGET=${SUBTARGET:-generic}
OPENWRT_VERSION=${OPENWRT_VERSION:-23.05.5}
FLAVORS="mini default full"
# FLAVORS="default full"
PROFILE_mini="profile-libremesh-suggested-packages-tiny"
PROFILE_default="profile-libremesh-suggested-packages"
PROFILE_full="profile-libremesh-suggested-packages pirania ubus-tmate"
PACKAGES_SET=mini

T_S=${TARGET}_${SUBTARGET}
TdS=${TARGET}-${SUBTARGET}
TsS=${TARGET}/${SUBTARGET}

TAG=${TdS}-v${OPENWRT_VERSION}
REPOSITORY=libremesh/openwrt-buildroot
#DATE="$(date "+%Y%m%d")"
DATE=20241225
TESTMODE=0
SKIP_TESTS=0
# do a new build after removal of profiles too small
REBUILD_PROFILES=0

function p_set() { echo $PACKAGES_SET ; }
function pr_set() { pr=PROFILE_$(p_set) && echo "${!pr}"; }
function build_options() {
  if [ $TESTMODE -eq 0 ]; then echo "-j$(nproc) IGNORE_ERRORS=\"n m\"" 
  else echo "-i -j$(nproc) IGNORE_ERRORS=\"n m\"" 
  fi
}

function build {
  echo "build $(p_set)" 
  echo $(date) > $LOGS_FILE
  docker exec $TAG sh -c "\
    make $(build_options) EXTRA_IMAGE_NAME=$(p_set) >> $C_LOGS_FILE 2>&1 \
    && mkdir -p $SUBTARGET_BIN_DIR/$(p_set) \
    && find $SUBTARGET_BIN_DIR -maxdepth 1 -type f | xargs -i mv {} $SUBTARGET_BIN_DIR/$(p_set)"
  echo $(date) >> $LOGS_FILE
}

function check_failure { 
  if grep -q "is too big" $LOGS_FILE; then
    devices_failed=$(grep "is too big" $LOGS_FILE | sed "s/^\(.*\)${TdS}-\(.*\)-\(squash\|initramfs\)\(.*\)/\\n\2/g" | sort | uniq )
    
    # append failing profiles to eg. configs/23.05.5/full/config_ath79_generic
    echo "# autodetected failures $LIBREMESH_VERSION-$PACKAGES_SET" >> $CONFIG_USED
    for d in $devices_failed; do
	    echo "# CONFIG_TARGET_DEVICE_${T_S}_DEVICE_${d} is not set" >> $CONFIG_USED
    done
   
    # apply updated config with excluded devices
    docker exec $TAG sh -c "cat $CONFIG_USED >> .config; make defconfig"

    # rebuild
    if [ $REBUILD_PROFILES -eq 1 ]; then
      TESTMODE=0 && build
    fi
  fi
}

# main
if [ ! -d lime-packages ]; then
  git clone https://github.com/libremesh/lime-packages
else
  cd lime-packages && git pull https://github.com/libremesh/lime-packages
  cd ..
fi

REV=$(cd lime-packages && git rev-parse --short=7 HEAD)
echo $REV
SUBTARGET_BIN_DIR=bin/targets/$TsS

BRANCH="$(cd lime-packages && git rev-parse --abbrev-ref HEAD)"
LIBREMESH_VERSION="${BRANCH}-ow${OPENWRT_VERSION}-${REV}-${DATE}"
BIN_DIR="$(pwd)"/bin_dir/$LIBREMESH_VERSION
LOGS_DIR="$(pwd)"/logs_dir/$LIBREMESH_VERSION
CONFIG_DIR="$(pwd)"/configs
CONFIG_AUTO="configs/${OPENWRT_VERSION}/config_${T_S}.autogen"
REVISION=.revision_${TAG}

if [ -f $REVISION ] && [ $(echo ${REV} ) == $( cat $REVISION ) ]; then
  echo 'Unchanged'
  exit 0;
else
  echo "build $REV"

  mkdir -p $BIN_DIR $LOGS_DIR;
  docker run -it -d \
    -v $BIN_DIR:/builder/bin \
    -v $LOGS_DIR:/builder/logs_dir \
    -v $CONFIG_DIR:/builder/configs \
    -v "$(pwd)"/scripts:/builder/build-scripts \
    --name $TAG $REPOSITORY:$TAG
  docker exec $TAG sh -c "\
    ./scripts/feeds update libremesh profiles \
    && ./scripts/feeds install -p libremesh -f -a \
    && ./scripts/feeds install -p profiles -f -a \
    && echo 'CONFIG_VERSION_NUMBER=\"${LIBREMESH_VERSION}\"' >> .config \
    && make defconfig \
    && mkdir -p /builder/files/etc/opkg \
    && echo 'src/gz kernel_modules https://downloads.libremesh.org/development/$LIBREMESH_VERSION/targets/$TsS/packages' > files/etc/opkg/kernel_modules.conf"

  if [ $(docker exec $TAG grep -q DEVICE_generic .config) ] || [ $SKIP_TESTS -eq 1 ]; then
    # direct build
    docker exec $TAG sh -c "cat ${CONFIG_AUTO} >> .config; make defconfig"

    for f in $FLAVORS; do
      PACKAGES_SET=$f
      LOGS_FILE=$LOGS_DIR/$TAG-$(p_set).txt
      C_LOGS_FILE=logs_dir/$TAG-$(p_set).txt
      CONFIG_USED="configs/${OPENWRT_VERSION}/$(p_set)/config_${T_S}"
      build
    done

  else
    # testmode
    
    # smaller build: disable all kmods
    docker exec $TAG sh -c "/builder/build-scripts/disable_all_kmods"

    # target specific
    docker exec $TAG sh -c "/builder/build-scripts/enable_all_profiles"
    docker exec $TAG sh -c "cat $CONFIG_AUTO >> .config; make defconfig"

    for f in $FLAVORS; do
      PACKAGES_SET=$f
      LOGS_FILE=$LOGS_DIR/$TAG-$(p_set).txt
      C_LOGS_FILE=logs_dir/$TAG-$(p_set).txt
      CONFIG_USED="configs/${OPENWRT_VERSION}/$(p_set)/config_${T_S}"

      # excluded devices
      docker exec $TAG sh -c "cat $CONFIG_USED >> .config; make defconfig"

      # packages set
      docker exec $TAG sh -c "sed -i s'|CONFIG_PACKAGE_profile\(.*\)=y|#\ CONFIG_PACKAGE_profile\1\ is\ not\ set |g' .config"
      for p in $(pr_set); do
        docker exec $TAG sh -c "\
          echo 'CONFIG_PACKAGE_$p=y' >> .config; \
          echo $p | grep -q 'profile' && make defconfig"
      done
      docker exec $TAG make defconfig

      # build testmode
      build

      # if build failed
      if [ $TESTMODE -eq 1 ]; then check_failure; fi

    done
    
    docker rm -vf $TAG
    echo ${REV} > $REVISION;
  fi
fi
