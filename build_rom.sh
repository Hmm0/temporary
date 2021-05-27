# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/DerpFest-11/manifest.git -b 11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/derp-sdm660-common/Local-Manifests.git --depth 1 -b derp4.19 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch derp_X00T-userdebug
mka derp

# upload rom
rclone copy out/target/product/X00T/DerpFest*.zip cirrus:X00T -P
