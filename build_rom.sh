# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/P-404/platform_manifest -b rippa -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/MLZ94/local_manifest --depth 1 -b p404 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
cd frameworks/nat* && git revert 883f4ec3a1b4bf64db2e761a7feffa946fb5f6df && git revert 73044d256a17ce52fa0b0bb18806d29cfe6911a1 && cd .. && cd ..
source build/envsetup.sh
lunch p404-X00QD-userdebug
make p404

# upload rom
rclone copy out/target/product/X00QD/*2021*.zip cirrus:X00QD -P
