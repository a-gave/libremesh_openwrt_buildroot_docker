#/bin/bash

## enable all profiles
sed -i 's|#\ CONFIG_TARGET_\(.*\)_DEVICE_\(.*\)\ is\ not\ set|CONFIG_TARGET_\1_DEVICE_\2=y|g' .config

# remove profiles that make to fail the build
cat << EOF >> .config
# CONFIG_TARGET_DEVICE_ath79_generic_DEVICE_belkin_f9j1108-v2 is not set
# CONFIG_TARGET_DEVICE_ath79_generic_DEVICE_belkin_f9k1115-v2 is not set
# CONFIG_TARGET_DEVICE_ath79_generic_DEVICE_dlink_dap-1330-a1 is not set
# CONFIG_TARGET_DEVICE_ath79_generic_DEVICE_dlink_dap-1365-a1 is not set
# CONFIG_TARGET_DEVICE_ath79_generic_DEVICE_dlink_dch-g020-a1 is not set
# CONFIG_TARGET_DEVICE_ath79_generic_DEVICE_dlink_dir-825-b1 is not set
# CONFIG_TARGET_DEVICE_ath79_generic_DEVICE_nec_wg800hp is not set
# CONFIG_TARGET_DEVICE_ath79_generic_DEVICE_trendnet_tew-673gru is not set
CONFIG_TARGET_MULTI_PROFILE=y
EOF

# apply config
make defconfig

# build multicore
date ; make -j$(nproc) > build_log.txt 2>&1 ; date
