# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PixelExperience/manifest -b eleven-plus -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/flashokiller/manifest_pine --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_pine-userdebug
mka bacon

# upload rom
rclone copy out/target/product/pine/*.zip cirrus:pine -P
